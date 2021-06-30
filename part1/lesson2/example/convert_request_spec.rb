# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operations::Handler::ConvertRequest do
  describe 'unit test' do
    let(:request) { instance_double('Request', short_uuid: '101', context_id: SecureRandom.uuid) }
    let(:build_request_result) do
      instance_double('Operations::Result', success?: true, value: request)
    end
    let(:request_json) { { request_id: 101 } }
    let(:serialize_request_result) do
      instance_double(
        'Operations::Result', success?: true, value: request_json
      )
    end
    let(:json) do
      {
        request: request_json
      }
    end
    let(:validate_result) do
      instance_double('Operations::Result', success?: true, value: request)
    end
    let(:serializer) { double }
    let(:bpm_service) { double }
    let(:event_logger_service) { double }
    let(:call!) { described_class.call(data) }
    let(:data) do
      Tests::Helpers.parse_json_file(
        'spec/fixtures/messages/convert.json'
      )
    end
    let(:routing_key) { data[:params][:outcome_routing_key] }

    before do
      allow(Operations::Builder::Request).to receive(:call)
        .with(data)
        .and_return(build_request_result)
      allow(Operations::Collect::DataFull).to receive(:call)
        .with(request)
      allow(Operations::Serialize::Request).to receive(:call)
        .with(request)
        .and_return(serialize_request_result)
      allow(Services::Bpm).to receive(:new).and_return(bpm_service)
      allow(bpm_service).to receive(:send_convert_done)
        .with(request.short_uuid, json, routing_key)
      allow(Services::EventLogger).to receive(:new).and_return(event_logger_service)
      allow(event_logger_service).to receive(:send_event)
    end

    context 'with valid data' do
      before do
        allow(request).to receive(:simple_documents?).and_return(false)
        allow(Operations::Validate::Request).to receive(:call)
          .with(request, request.simple_documents?)
          .and_return(build_request_result)
      end

      it 'returns success' do
        result = call!
        expect(result.success?).to be true
      end

      it 'builds request and collects data' do
        call!
        expect(Operations::Builder::Request).to have_received(:call).with(data)
        expect(Operations::Collect::DataFull).to have_received(:call).with(request)
      end

      it 'validates request' do
        call!
        expect(Operations::Validate::Request).to have_received(:call)
          .with(request, request.simple_documents?)
      end

      it 'serialize and sends to bpm' do
        call!
        expect(Operations::Serialize::Request).to have_received(:call).with(request)
        expect(bpm_service).to have_received(:send_convert_done)
          .with(request.short_uuid, json, routing_key)
      end
    end

    context 'with valid_data on simple_documents' do
      before do
        allow(Operations::Validate::Request).to receive(:call)
          .with(request, true)
          .and_return(build_request_result)
        allow(request).to receive(:simple_documents?).and_return(true)
      end

      it 'returns success' do
        result = call!
        expect(result.success?).to be true
      end

      it 'builds request and collects data' do
        call!
        expect(Operations::Builder::Request).to have_received(:call).with(data)
        expect(Operations::Collect::DataFull).to have_received(:call).with(request)
      end

      it 'validates request' do
        call!
        expect(Operations::Validate::Request).to have_received(:call).with(request, true)
      end

      it 'serialize and sends to bpm' do
        call!
        expect(Operations::Serialize::Request).to have_received(:call).with(request)
        expect(bpm_service).to have_received(:send_convert_done)
          .with(request.short_uuid, json, routing_key)
      end
    end
  end

  describe 'integration test', :mock_bunny do
    let(:call!) { described_class.call(data) }
    let(:routing_key) { data[:params][:outcome_routing_key] }
    let(:request_id) do
      data.dig(:params, :context, :request_id)
    end
    let(:time) { Time.zone.local(2019, 12, 10, 10, 11, 22) }
    let(:bpm_service) { double }
    let(:event_logger_service) { double }
    let(:error_json) { { error: true } }
    let(:success_case_before) do
      allow(Services::Bpm).to receive(:new).and_return(bpm_service)
      allow(bpm_service).to receive(:send_convert_done).with(data[:id], json, routing_key)
      allow(Services::EventLogger).to receive(:new).and_return(event_logger_service)
      allow(event_logger_service).to receive(:send_event)
    end
    let(:error_case_before) do
      allow(Services::Bpm).to receive(:new).and_return(bpm_service)
      allow(Services::EventLogger).to receive(:new).and_return(event_logger_service)
      allow(bpm_service).to receive(:send_convert_done).with(data[:id], error_json, routing_key)
      allow(event_logger_service).to receive(:send_event)
    end

    context 'with Operations::Collect::RejectIncompleteJobs mocked' do
      before do
        allow(Operations::Collect::RejectIncompleteJobs).to receive(:call)
      end

      context 'with some success data' do
        let(:data) do
          Tests::Helpers.parse_json_file(
            'spec/fixtures/messages/convert.json'
          )
        end
        let(:json) { kind_of(Hash) }

        before do
          success_case_before
        end

        it 'returns success' do
          Timecop.travel(time) do
            result = call!
            expect(result.success?).to be true
          end
        end
      end

      # TODO(khataev): По-хорошему, необходимо пройтись по всем json и добавить ключ
      # calculation, тк при его отсутствии создадутся калькуляции на несколько программ, но это пока
      # не критично, тк особо ни на что не влияет
      context 'with children' do
        let(:bpm_service) { double }

        before do
          success_case_before
        end

        context 'when only in questionary' do
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/relatives/01_in_questionary.json'
            )
          end
          let(:relativeData) do
            [
              {
                relencumbrance: 'N',
                relrelatedPartyContactBirthDate: '10/20/1971',
                relcohabitation: 'Y',
                relrelatedPartyContactFirstName: 'Имя',
                relrelatedPartyContactLastName: 'Фамилия',
                relrelatedPartyContactMiddleName: 'Отчество',
                relrelationshipType: 'Son'
              }
            ]
          end
          let(:json) do
            # TODO(khataev): отрефачить код, чтобы не строить такие многоуровневые ожидания
            # json.dig(:request, :listOfOptInfo, :opty)
            #     .first.dig(:listOfOptyContacts, :optyContacts)
            #     .first.dig(:listOfContactRelation, :contactRelation)
            hash_including(
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: [
                    hash_including(
                      listOfOptyContacts: hash_including(
                        optyContacts: [
                          hash_including(
                            listOfContactRelation: hash_including(contactRelation: relativeData)
                          )
                        ]
                      )
                    )
                  ]
                )
              )
            )
          end

          it 'returns success' do
            Timecop.travel(time) do
              result = call!
              expect(result.success?).to be true
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
            end
          end
        end

        context 'when only in passport' do
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/relatives/02_in_passport.json'
            )
          end
          let(:relativeData) do
            [
              {
                relencumbrance: 'Y',
                relrelatedPartyContactBirthDate: '12/11/2001',
                relcohabitation: 'Y',
                relrelatedPartyContactFirstName: 'Имя',
                relrelatedPartyContactLastName: 'Фамилия',
                relrelatedPartyContactMiddleName: 'Отчество',
                relrelationshipType: 'Son'
              },
              {
                relencumbrance: 'N',
                relrelatedPartyContactBirthDate: '12/10/2001',
                relcohabitation: 'N',
                relrelatedPartyContactFirstName: 'Имя1',
                relrelatedPartyContactLastName: 'Фамилия1',
                relrelatedPartyContactMiddleName: 'Отчество1',
                relrelationshipType: 'Daughter'
              }
            ]
          end
          let(:json) do
            # TODO(khataev): отрефачить код, чтобы не строить такие многоуровневые ожидания
            # json.dig(:request, :listOfOptInfo, :opty)
            #     .first.dig(:listOfOptyContacts, :optyContacts)
            #     .first.dig(:listOfContactRelation, :contactRelation)
            hash_including(
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: [
                    hash_including(
                      listOfOptyContacts: hash_including(
                        optyContacts: [
                          hash_including(
                            listOfContactRelation: hash_including(contactRelation: relativeData)
                          )
                        ]
                      )
                    )
                  ]
                )
              )
            )
          end

          it 'returns success' do
            Timecop.travel(time) do
              result = call!
              expect(result.success?).to be true
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
            end
          end
        end

        context 'when both in questionary and passport' do
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/relatives/03_in_questionary_and_passport.json'
            )
          end
          let(:relativeData) do
            [
              {
                relencumbrance: 'N',
                relrelatedPartyContactBirthDate: '10/20/1971',
                relcohabitation: 'Y',
                relrelatedPartyContactFirstName: 'Имя1',
                relrelatedPartyContactLastName: 'Фамилия1',
                relrelatedPartyContactMiddleName: 'Отчество1',
                relrelationshipType: 'Son'
              },
              {
                relencumbrance: 'N',
                relrelatedPartyContactBirthDate: '10/10/2001',
                relcohabitation: 'Y',
                relrelatedPartyContactFirstName: 'Имя2',
                relrelatedPartyContactLastName: 'Фамилия2',
                relrelatedPartyContactMiddleName: 'Отчество2',
                relrelationshipType: 'Daughter'
              },
              {
                relencumbrance: 'Y',
                relrelatedPartyContactBirthDate: '10/10/2002',
                relcohabitation: 'Y',
                relrelatedPartyContactFirstName: 'Имя2',
                relrelatedPartyContactLastName: 'Фамилия2',
                relrelatedPartyContactMiddleName: 'Отчество2',
                relrelationshipType: 'Daughter'
              }
            ]
          end
          let(:json) do
            # TODO(khataev): отрефачить код, чтобы не строить такие многоуровневые ожидания
            # json.dig(:request, :listOfOptInfo, :opty)
            #     .first.dig(:listOfOptyContacts, :optyContacts)
            #     .first.dig(:listOfContactRelation, :contactRelation)
            hash_including(
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: [
                    hash_including(
                      listOfOptyContacts: hash_including(
                        optyContacts: [
                          hash_including(
                            listOfContactRelation: hash_including(contactRelation: relativeData)
                          )
                        ]
                      )
                    )
                  ]
                )
              )
            )
          end

          it 'returns success' do
            Timecop.travel(time) do
              result = call!
              expect(result.success?).to be true
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
            end
          end
        end
      end

      context 'with spouses' do
        let(:bpm_service) { double }
        let(:event_logger_service) { double }
        let(:context_id) { data[:params][:context][:request_id] }

        context 'when two single person' do
          let(:time) { Time.zone.local(2020, 3, 15, 10, 11, 22) }
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/spouses/05.json'
            )
          end
          let(:json) do
            hash_including(
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: [
                    hash_including(
                      listOfOptyContacts: hash_including(
                        optyContacts: array_including(
                          hash_including(
                            listOfContactRelation: hash_including(
                              contactRelation: []
                            )
                          ),
                          hash_including(
                            listOfContactRelation: hash_including(
                              contactRelation: []
                            )
                          )
                        )
                      )
                    )
                  ]
                )
              )
            )
          end

          before do
            success_case_before
          end

          it 'returns success' do
            Timecop.travel(time) do
              result = call!
              expect(result.success?).to be true
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
            end
          end
        end

        context 'when no marital certificate' do
          context 'when must bring marital certificate on deal' do
            let(:time) { Time.zone.local(2020, 2, 15, 10, 11, 22) }
            let(:data) do
              Tests::Helpers.parse_json_file(
                'spec/fixtures/messages/convert/spouses/01.json'
              )
            end
            let(:relative1Data) do
              [
                {
                  relencumbrance: 'N',
                  relrelatedPartyContactBirthDate: '05/11/1982',
                  relcohabitation: 'Y',
                  relrelatedPartyContactFirstName: 'ПОЛИНА',
                  relrelatedPartyContactLastName: 'ВОЛКОВА',
                  relrelatedPartyContactMiddleName: 'АЛЕКСАНДРОВНА',
                  relrelationshipType: 'Spouse'
                }
              ]
            end
            let(:expected_optyComment) do
              'ВОЛКОВ АЛЕКСАНДР ИВАНОВИЧ: принести на сделку Брачный договор'
            end
            let(:json) do
              hash_including(
                request: hash_including(
                  listOfOptInfo: hash_including(
                    opty: [
                      hash_including(
                        optyComment: include(expected_optyComment),
                        listOfOptyContacts: hash_including(
                          optyContacts: array_including(
                            hash_including(
                              listOfContactRelation: hash_including(
                                contactRelation: relative1Data
                              )
                            )
                          )
                        )
                      )
                    ]
                  )
                )
              )
            end

            before do
              success_case_before
            end

            it 'returns errors' do
              Timecop.travel(time) do
                result = call!
                expect(result).to be_success
                expect(bpm_service)
                  .to have_received(:send_convert_done).with(data[:id], json, routing_key)
              end
            end
          end

          context 'when different marital status in questionary and passport' do
            let(:time) { Time.zone.local(2020, 8, 20) }
            let(:data) do
              Tests::Helpers.parse_json_file(
                'spec/fixtures/messages/convert/spouses/02.json'
              )
            end
            let(:relative1Data) do
              {
                relencumbrance: 'N',
                relrelatedPartyContactBirthDate: '10/20/1991',
                relcohabitation: 'Y',
                relrelatedPartyContactFirstName: 'Супруга',
                relrelatedPartyContactLastName: 'Одиннадцатый',
                relrelatedPartyContactMiddleName: 'Тест',
                relrelationshipType: 'Spouse'
              }
            end
            let(:json) do
              hash_including(
                request: hash_including(
                  listOfOptInfo: hash_including(
                    opty: [
                      hash_including(
                        listOfOptyContacts: hash_including(
                          optyContacts: array_including(
                            hash_including(
                              contMaritalStatus: 'Married',
                              listOfContactRelation: hash_including(
                                contactRelation: array_including(relative1Data)
                              )
                            )
                          )
                        )
                      )
                    ]
                  )
                )
              )
            end

            before do
              success_case_before
            end

            it 'returns success' do
              Timecop.travel(time) do
                result = call!
                expect(result.success?).to be true
                expect(bpm_service)
                  .to have_received(:send_convert_done).with(data[:id], json, routing_key)
              end
            end
          end

          context 'when no relatives in questionary (by marriage date in passport)' do
            let(:time) { Time.zone.local(2020, 2, 15, 10, 11, 22) }
            let(:data) do
              Tests::Helpers.parse_json_file(
                'spec/fixtures/messages/convert/spouses/03.json'
              )
            end
            let(:relative1Data) do
              {
                relencumbrance: 'N',
                relrelatedPartyContactBirthDate: '05/11/1982',
                relcohabitation: 'Y',
                relrelatedPartyContactFirstName: 'ПОЛИНА',
                relrelatedPartyContactLastName: 'ВОЛКОВА',
                relrelatedPartyContactMiddleName: 'АЛЕКСАНДРОВНА',
                relrelationshipType: 'Spouse'
              }
            end
            let(:relative2Data) do
              {
                relencumbrance: 'N',
                relrelatedPartyContactBirthDate: '11/13/1978',
                relcohabitation: 'Y',
                relrelatedPartyContactFirstName: 'АЛЕКСАНДР',
                relrelatedPartyContactLastName: 'ВОЛКОВ',
                relrelatedPartyContactMiddleName: 'ИВАНОВИЧ',
                relrelationshipType: 'Spouse'
              }
            end
            let(:json) do
              hash_including(
                request: hash_including(
                  listOfOptInfo: hash_including(
                    opty: [
                      hash_including(
                        listOfOptyContacts: hash_including(
                          optyContacts: array_including(
                            hash_including(
                              listOfContactRelation: hash_including(
                                contactRelation: [relative1Data]
                              )
                            ),
                            hash_including(
                              listOfContactRelation: hash_including(
                                contactRelation: [relative2Data]
                              )
                            )
                          )
                        )
                      )
                    ]
                  )
                )
              )
            end

            before do
              success_case_before
            end

            it 'returns success' do
              Timecop.travel(time) do
                result = call!
                expect(result.success?).to be true
                expect(bpm_service)
                  .to have_received(:send_convert_done).with(data[:id], json, routing_key)
              end
            end
          end

          context 'when no relation type specified in questionary' do
            let(:time) { Time.zone.local(2020, 2, 15, 10, 11, 22) }
            let(:data) do
              Tests::Helpers.parse_json_file(
                'spec/fixtures/messages/convert/spouses/04.json'
              )
            end
            let(:relative1Data) do
              {
                relencumbrance: 'N',
                relrelatedPartyContactBirthDate: '05/11/1982',
                relcohabitation: 'Y',
                relrelatedPartyContactFirstName: 'ПОЛИНА',
                relrelatedPartyContactLastName: 'ВОЛКОВА',
                relrelatedPartyContactMiddleName: 'АЛЕКСАНДРОВНА',
                relrelationshipType: 'Spouse'
              }
            end
            let(:relative2Data) do
              {
                relencumbrance: 'N',
                relrelatedPartyContactBirthDate: '11/13/1978',
                relcohabitation: 'Y',
                relrelatedPartyContactFirstName: 'АЛЕКСАНДР',
                relrelatedPartyContactLastName: 'ВОЛКОВ',
                relrelatedPartyContactMiddleName: 'ИВАНОВИЧ',
                relrelationshipType: 'Spouse'
              }
            end
            let(:expected_optyComment) do
              'ВОЛКОВ АЛЕКСАНДР ИВАНОВИЧ: совпадение выявлено по косвенным признакам;'\
            'ВОЛКОВА ПОЛИНА АЛЕКСАНДРОВНА: совпадение выявлено по косвенным признакам'
            end
            let(:json) do
              hash_including(
                request: hash_including(
                  listOfOptInfo: hash_including(
                    opty: [
                      hash_including(
                        optyComment: include(expected_optyComment),
                        listOfOptyContacts: hash_including(
                          optyContacts: array_including(
                            hash_including(
                              listOfContactRelation: hash_including(
                                contactRelation: [relative1Data]
                              )
                            ),
                            hash_including(
                              listOfContactRelation: hash_including(
                                contactRelation: [relative2Data]
                              )
                            )
                          )
                        )
                      )
                    ]
                  )
                )
              )
            end

            before do
              success_case_before
            end

            it 'returns success' do
              Timecop.travel(time) do
                result = call!
                expect(result.success?).to be true
                expect(bpm_service)
                  .to have_received(:send_convert_done).with(data[:id], json, routing_key)
              end
            end
          end

          context 'when no relation type specified for child in questionary' do
            let(:time) { Time.zone.local(2020, 2, 15, 10, 11, 22) }
            let(:data) do
              Tests::Helpers.parse_json_file(
                'spec/fixtures/messages/convert/spouses/09.json'
              )
            end
            let(:relative1Data) do
              {
                relencumbrance: 'N',
                relrelatedPartyContactBirthDate: '05/11/1982',
                relcohabitation: 'Y',
                relrelatedPartyContactFirstName: 'ПОЛИНА',
                relrelatedPartyContactLastName: 'ВОЛКОВА',
                relrelatedPartyContactMiddleName: 'АЛЕКСАНДРОВНА',
                relrelationshipType: 'Spouse'
              }
            end
            let(:relative2Data) do
              [
                {
                  relencumbrance: 'N',
                  relrelatedPartyContactBirthDate: '11/13/1978',
                  relcohabitation: 'Y',
                  relrelatedPartyContactFirstName: 'АЛЕКСАНДР',
                  relrelatedPartyContactLastName: 'ВОЛКОВ',
                  relrelatedPartyContactMiddleName: 'ИВАНОВИЧ',
                  relrelationshipType: 'Spouse'
                },
                {
                  relencumbrance: 'N',
                  relrelatedPartyContactBirthDate: '10/10/2001',
                  relcohabitation: 'Y',
                  relrelatedPartyContactFirstName: 'АЛЕКСАНДР',
                  relrelatedPartyContactLastName: 'ВОЛКОВ',
                  relrelatedPartyContactMiddleName: 'ИВАНОВИЧ',
                  relrelationshipType: nil
                }
              ]
            end
            let(:unexpected_optyComment) do
              'совпадение выявлено по косвенным признакам'
            end
            let(:json) do
              hash_including(
                request: hash_including(
                  listOfOptInfo: hash_including(
                    opty: [
                      hash_including(
                        optyComment: exclude(unexpected_optyComment),
                        listOfOptyContacts: hash_including(
                          optyContacts: array_including(
                            hash_including(
                              # TODO(khataev): перенести скобки массива в переменные
                              listOfContactRelation: hash_including(
                                contactRelation: [relative1Data]
                              )
                            ),
                            hash_including(
                              listOfContactRelation: hash_including(
                                contactRelation: relative2Data
                              )
                            )
                          )
                        )
                      )
                    ]
                  )
                )
              )
            end

            before do
              success_case_before
            end

            it 'returns success' do
              Timecop.travel(time) do
                result = call!
                expect(result.success?).to be true
                expect(bpm_service)
                  .to have_received(:send_convert_done).with(data[:id], json, routing_key)
              end
            end
          end

          context 'when spouses by marriage date' do
            let(:time) { Time.zone.local(2020, 8, 19, 10, 11, 22) }
            let(:data) do
              Tests::Helpers.parse_json_file(
                'spec/fixtures/messages/convert/spouses/11.json'
              )
            end
            let(:relative1Data) do
              {
                relencumbrance: 'N',
                relrelatedPartyContactBirthDate: '10/20/1991',
                relcohabitation: 'Y',
                relrelatedPartyContactFirstName: 'Созаемщик',
                relrelatedPartyContactLastName: 'Сороквторой',
                relrelatedPartyContactMiddleName: 'Тест',
                relrelationshipType: 'Spouse'
              }
            end
            let(:relative2Data) do
              {
                relencumbrance: 'N',
                relrelatedPartyContactBirthDate: '10/20/1991',
                relcohabitation: 'Y',
                relrelatedPartyContactFirstName: 'Заемщик',
                relrelatedPartyContactLastName: 'Сороквторой',
                relrelatedPartyContactMiddleName: 'Тест',
                relrelationshipType: 'Spouse'
              }
            end
            let(:expected_optyComment) do
              'Сороквторой Заемщик Тест: совпадение выявлено по косвенным признакам;'\
            'Сороквторой Созаемщик Тест: совпадение выявлено по косвенным признакам'
            end
            let(:json) do
              hash_including(
                request: hash_including(
                  listOfOptInfo: hash_including(
                    opty: [
                      hash_including(
                        optyComment: include(expected_optyComment),
                        listOfOptyContacts: hash_including(
                          optyContacts: array_including(
                            hash_including(
                              listOfContactRelation: hash_including(
                                contactRelation: [relative1Data]
                              )
                            ),
                            hash_including(
                              listOfContactRelation: hash_including(
                                contactRelation: [relative2Data]
                              )
                            )
                          )
                        )
                      )
                    ]
                  )
                )
              )
            end

            before do
              success_case_before
            end

            it 'returns success' do
              Timecop.travel(time) do
                result = call!
                expect(result.success?).to be true
                expect(bpm_service)
                  .to have_received(:send_convert_done).with(data[:id], json, routing_key)
              end
            end
          end

          context 'when spouse in passport and we should not generate comment' do
            let(:time) { Time.zone.local(2020, 8, 19, 10, 11, 22) }
            let(:data) do
              Tests::Helpers.parse_json_file(
                'spec/fixtures/messages/convert/spouses/12.json'
              )
            end
            let(:relative1Data) do
              {
                relencumbrance: 'N',
                relrelatedPartyContactBirthDate: '10/20/1991',
                relcohabitation: 'Y',
                relrelatedPartyContactFirstName: 'Созаемщик',
                relrelatedPartyContactLastName: 'Тридцатьвторой',
                relrelatedPartyContactMiddleName: 'Тест',
                relrelationshipType: 'Spouse'
              }
            end
            let(:relative2Data) do
              {
                relencumbrance: 'N',
                relrelatedPartyContactBirthDate: '10/20/1991',
                relcohabitation: 'Y',
                relrelatedPartyContactFirstName: 'Полный',
                relrelatedPartyContactLastName: 'Тридцатьвторой',
                relrelatedPartyContactMiddleName: 'Тест',
                relrelationshipType: 'Spouse'
              }
            end
            let(:unexpected_optyComment) do
              'совпадение выявлено по косвенным признакам'
            end
            let(:json) do
              hash_including(
                request: hash_including(
                  listOfOptInfo: hash_including(
                    opty: [
                      hash_including(
                        optyComment: exclude(unexpected_optyComment),
                        listOfOptyContacts: hash_including(
                          optyContacts: array_including(
                            hash_including(
                              listOfContactRelation: hash_including(
                                contactRelation: [relative1Data]
                              )
                            ),
                            hash_including(
                              listOfContactRelation: hash_including(
                                contactRelation: [relative2Data]
                              )
                            )
                          )
                        )
                      )
                    ]
                  )
                )
              )
            end

            before do
              success_case_before
            end

            it 'returns success' do
              Timecop.travel(time) do
                result = call!
                expect(result.success?).to be true
                expect(bpm_service)
                  .to have_received(:send_convert_done).with(data[:id], json, routing_key)
              end
            end
          end

          context 'when spouse in passport and we should generate comment' do
            let(:time) { Time.zone.local(2020, 8, 19, 10, 11, 22) }
            let(:data) do
              Tests::Helpers.parse_json_file(
                'spec/fixtures/messages/convert/spouses/13.json'
              )
            end
            let(:relative1Data) do
              {
                relencumbrance: 'N',
                relrelatedPartyContactBirthDate: '10/20/1991',
                relcohabitation: 'Y',
                relrelatedPartyContactFirstName: 'Созаемщик',
                relrelatedPartyContactLastName: 'Тридцатьвторой',
                relrelatedPartyContactMiddleName: 'Тест',
                relrelationshipType: 'Spouse'
              }
            end
            let(:relative2Data) do
              {
                relencumbrance: 'N',
                relrelatedPartyContactBirthDate: '10/20/1991',
                relcohabitation: 'Y',
                relrelatedPartyContactFirstName: 'Полный',
                relrelatedPartyContactLastName: 'Тридцатьвторой',
                relrelatedPartyContactMiddleName: 'Тест',
                relrelationshipType: 'Spouse'
              }
            end
            let(:expected_optyComment) do
              'Тридцатьвторой Полный Тест: совпадение выявлено по косвенным признакам'
            end
            let(:json) do
              hash_including(
                request: hash_including(
                  listOfOptInfo: hash_including(
                    opty: [
                      hash_including(
                        optyComment: include(expected_optyComment),
                        listOfOptyContacts: hash_including(
                          optyContacts: array_including(
                            hash_including(
                              listOfContactRelation: hash_including(
                                contactRelation: [relative1Data]
                              )
                            ),
                            hash_including(
                              listOfContactRelation: hash_including(
                                contactRelation: [relative2Data]
                              )
                            )
                          )
                        )
                      )
                    ]
                  )
                )
              )
            end

            before do
              success_case_before
            end

            it 'returns success' do
              Timecop.travel(time) do
                result = call!
                expect(result.success?).to be true
                expect(bpm_service)
                  .to have_received(:send_convert_done).with(data[:id], json, routing_key)
              end
            end
          end

          context 'when one spouse has no marriage stamp in passport (<5>+<6>)' do
            let(:time) { Time.zone.local(2020, 8, 13) }
            let(:data) do
              Tests::Helpers.parse_json_file(
                'spec/fixtures/messages/convert/spouses/16.json'
              )
            end
            let(:relative1Data) do
              {
                relencumbrance: 'N',
                relrelatedPartyContactBirthDate: '10/20/1991',
                relcohabitation: 'Y',
                relrelatedPartyContactFirstName: 'Созаемщик',
                relrelatedPartyContactLastName: 'Сороковой',
                relrelatedPartyContactMiddleName: 'Тест',
                relrelationshipType: 'Spouse'
              }
            end
            let(:relative2Data) do
              {
                relencumbrance: 'N',
                relrelatedPartyContactBirthDate: '10/20/1991',
                relcohabitation: 'Y',
                relrelatedPartyContactFirstName: 'Заемщик',
                relrelatedPartyContactLastName: 'Сороковой',
                relrelatedPartyContactMiddleName: 'Тест',
                relrelationshipType: 'Spouse'
              }
            end
            let(:expected_optyComment) do
              'Сороковой Заемщик Тест: совпадение выявлено по косвенным признакам'
            end
            let(:json) do
              hash_including(
                request: hash_including(
                  listOfOptInfo: hash_including(
                    opty: [
                      hash_including(
                        optyComment: include(expected_optyComment),
                        listOfOptyContacts: hash_including(
                          optyContacts: array_including(
                            hash_including(
                              listOfContactRelation: hash_including(
                                contactRelation: [relative1Data]
                              )
                            ),
                            hash_including(
                              listOfContactRelation: hash_including(
                                contactRelation: [relative2Data]
                              )
                            )
                          )
                        )
                      )
                    ]
                  )
                )
              )
            end

            before do
              success_case_before
            end

            it 'returns success' do
              Timecop.travel(time) do
                result = call!
                expect(result.success?).to be true
                expect(bpm_service)
                  .to have_received(:send_convert_done).with(data[:id], json, routing_key)
              end
            end
          end
        end

        context 'when marital certificate (no checking by marriage date)' do
          context 'when passport partner is present' do
            let(:time) { Time.zone.local(2020, 2, 15, 10, 11, 22) }
            let(:data) do
              Tests::Helpers.parse_json_file(
                'spec/fixtures/messages/convert/spouses/07.json'
              )
            end
            let(:relative1Data) do
              {
                relencumbrance: 'N',
                relrelatedPartyContactBirthDate: '05/11/1982',
                relcohabitation: 'Y',
                relrelatedPartyContactFirstName: 'ПОЛИНА',
                relrelatedPartyContactLastName: 'ВОЛКОВА',
                relrelatedPartyContactMiddleName: 'АЛЕКСАНДРОВНА',
                relrelationshipType: 'Spouse'
              }
            end
            let(:relative2Data) do
              {
                relencumbrance: 'N',
                relrelatedPartyContactBirthDate: '11/13/1978',
                relcohabitation: 'Y',
                relrelatedPartyContactFirstName: 'АЛЕКСАНДЭР',
                relrelatedPartyContactLastName: 'ВОЛКОФ',
                relrelatedPartyContactMiddleName: 'ИВАНОВИЧ',
                relrelationshipType: 'Spouse'
              }
            end
            let(:unexpected_optyComment) do
              'ВОЛКОВ АЛЕКСАНДР ИВАНОВИЧ: не указан тип родства для супруга в анкете, '\
          'совпадение выявлено по косвенным признакам'
            end
            let(:json) do
              hash_including(
                request: hash_including(
                  listOfOptInfo: hash_including(
                    opty: [
                      hash_including(
                        optyComment: exclude(unexpected_optyComment),
                        listOfOptyContacts: hash_including(
                          optyContacts: array_including(
                            hash_including(
                              listOfContactRelation: hash_including(
                                contactRelation: [relative1Data]
                              )
                            ),
                            hash_including(
                              listOfContactRelation: hash_including(
                                contactRelation: [relative2Data]
                              )
                            )
                          )
                        )
                      )
                    ]
                  )
                )
              )
            end

            before do
              success_case_before
            end

            it 'returns success' do
              Timecop.travel(time) do
                result = call!
                expect(result.success?).to be true
                expect(bpm_service)
                  .to have_received(:send_convert_done).with(data[:id], json, routing_key)
              end
            end
          end

          context 'when passport partner is absent' do
            let(:time) { Time.zone.local(2020, 9, 8, 10, 11, 22) }
            let(:data) do
              Tests::Helpers.parse_json_file(
                'spec/fixtures/messages/convert/spouses/08.json'
              )
            end
            let(:relative1Data) do
              {
                relencumbrance: 'Y',
                relrelatedPartyContactBirthDate: '06/17/2013',
                relcohabitation: 'Y',
                relrelatedPartyContactFirstName: 'ЭЛЬМИНА',
                relrelatedPartyContactLastName: 'ИСХАКОВА',
                relrelatedPartyContactMiddleName: 'ЭМИЛЕВНА',
                relrelationshipType: 'Son'
              }
            end
            let(:json) do
              hash_including(
                request: hash_including(
                  listOfOptInfo: hash_including(
                    opty: [
                      hash_including(
                        listOfOptyContacts: hash_including(
                          optyContacts: array_including(
                            hash_including(
                              listOfContactRelation: hash_including(
                                contactRelation: [relative1Data]
                              )
                            )
                          )
                        )
                      )
                    ]
                  )
                )
              )
            end

            before do
              success_case_before
            end

            it 'returns success' do
              Timecop.travel(time) do
                result = call!
                expect(result.success?).to be true
                expect(bpm_service)
                  .to have_received(:send_convert_done).with(data[:id], json, routing_key)
              end
            end
          end
        end
      end

      context 'with questionary' do
        let(:bpm_service) { double }
        let(:event_logger_service) { double }
        let(:context_id) { data[:params][:context][:request_id] }

        before do
          error_case_before
        end

        context 'with pension and no job' do
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/pension/simple_documents/no_job.json'
            )
          end
          let(:incomeData) do
            array_including(
              incomeAmount: '400000000000000.0',
              incomeDocumentType: 'Profile',
              incomeSource: 'Pension'
            )
          end
          let(:json) do
            hash_including(
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: [
                    hash_including(
                      listOfOptyContacts: hash_including(
                        optyContacts: [
                          hash_including(
                            listOfIncome: hash_including(income: incomeData)
                          )
                        ]
                      )
                    )
                  ]
                )
              )
            )
          end

          before do
            success_case_before
          end

          it 'returns success' do
            Timecop.travel(time) do
              result = call!
              expect(result.success?).to be true
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
            end
          end
        end

        context 'when one spouse has blank marriage in passport' do
          let(:time) { Time.zone.local(2020, 8, 20, 10, 11, 22) }
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/spouses/14.json'
            )
          end
          let(:relative1Data) do
            {
              relencumbrance: 'N',
              relrelatedPartyContactBirthDate: '01/01/1991',
              relcohabitation: 'Y',
              relrelatedPartyContactFirstName: 'Супруга',
              relrelatedPartyContactLastName: 'Шестьдесятпервая',
              relrelatedPartyContactMiddleName: 'Тест',
              relrelationshipType: 'Spouse'
            }
          end
          let(:relative2Data) do
            {
              relencumbrance: 'N',
              relrelatedPartyContactBirthDate: '10/20/1991',
              relcohabitation: 'Y',
              relrelatedPartyContactFirstName: 'Заемщик',
              relrelatedPartyContactLastName: 'Шестьдесятпервый',
              relrelatedPartyContactMiddleName: 'Тест',
              relrelationshipType: 'Spouse'
            }
          end
          let(:expected_optyComment) do
            'Шестьдесятпервый Заемщик Тест: совпадение выявлено по косвенным признакам'
          end
          let(:json) do
            hash_including(
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: [
                    hash_including(
                      optyComment: include(expected_optyComment),
                      listOfOptyContacts: hash_including(
                        optyContacts: array_including(
                          hash_including(
                            contMaritalStatus: 'Married',
                            listOfContactRelation: hash_including(
                              contactRelation: [relative1Data]
                            )
                          ),
                          hash_including(
                            listOfContactRelation: hash_including(
                              contactRelation: [relative2Data]
                            )
                          )
                        )
                      )
                    )
                  ]
                )
              )
            )
          end

          before do
            success_case_before
          end

          it 'returns success' do
            Timecop.travel(time) do
              result = call!
              expect(result.success?).to be true
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
            end
          end
        end

        context 'when one married borrower' do
          let(:time) { Time.zone.local(2020, 8, 6, 10, 11, 22) }
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/spouses/15.json'
            )
          end
          let(:relative1Data) do
            {
              relencumbrance: 'N',
              relrelatedPartyContactBirthDate: '07/31/1987',
              relcohabitation: 'Y',
              relrelatedPartyContactFirstName: 'ШЕРБЕК',
              relrelatedPartyContactLastName: 'ШАВКИЕВ',
              relrelatedPartyContactMiddleName: 'АЛИШЕРОВИЧ',
              relrelationshipType: 'Spouse'
            }
          end
          let(:json) do
            hash_including(
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: [
                    hash_including(
                      listOfOptyContacts: hash_including(
                        optyContacts: array_including(
                          hash_including(
                            contMaritalStatus: 'Married',
                            listOfContactRelation: hash_including(
                              contactRelation: [relative1Data]
                            )
                          )
                        )
                      )
                    )
                  ]
                )
              )
            )
          end

          before do
            success_case_before
          end

          it 'returns success' do
            Timecop.travel(time) do
              result = call!
              expect(result.success?).to be true
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
            end
          end
        end

        context 'with pension and with job' do
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/pension/simple_documents/job_with_pension.json'
            )
          end
          let(:incomeData) do
            array_including(
              incomeAmount: '300000.0',
              incomeDocumentType: 'Profile',
              incomeSource: 'Salary'
            )
          end
          let(:json) do
            hash_including(
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: [
                    hash_including(
                      listOfOptyContacts: hash_including(
                        optyContacts: [
                          hash_including(
                            listOfIncome: hash_including(income: incomeData)
                          )
                        ]
                      )
                    )
                  ]
                )
              )
            )
          end

          before do
            success_case_before
          end

          it 'returns success' do
            Timecop.travel(time) do
              result = call!
              expect(result.success?).to be true
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
            end
          end
        end

        context 'with main job and part-time job' do
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/documents/main_and_part_time_jobs.json'
            )
          end
          let(:incomeData) do
            array_including(
              incomeAmount: '300000.0',
              incomeDocumentType: 'Profile',
              incomeSource: 'Salary'
            )
          end
          let(:json) do
            hash_including(
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: [
                    hash_including(
                      listOfOptyContacts: hash_including(
                        optyContacts: [
                          hash_including(
                            listOfIncome: hash_including(income: incomeData)
                          )
                        ]
                      )
                    )
                  ]
                )
              )
            )
          end

          before do
            success_case_before
          end

          it 'returns success' do
            Timecop.travel(time) do
              result = call!
              expect(result.success?).to be true
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
            end
          end
        end
      end

      context 'with pension documents' do
        let(:event_logger_service) { double }
        let(:context_id) { data[:params][:context][:request_id] }

        context 'with pfr_certificate and bank_form income' do
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/pension/full_document_set/'\
            'with_pfr_certificate_and_bank_form.json'
            )
          end
          let(:incomeData) do
            array_including(
              incomeAmount: '3381034.5',
              incomeDocumentType: 'Reference form bank',
              incomeSource: 'Salary'
            )
          end
          let(:json) do
            hash_including(
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: [
                    hash_including(
                      listOfOptyContacts: hash_including(
                        optyContacts: [
                          hash_including(
                            listOfIncome: hash_including(income: incomeData)
                          )
                        ]
                      )
                    )
                  ]
                )
              )
            )
          end

          before do
            success_case_before
          end

          it 'returns success' do
            Timecop.travel(time) do
              result = call!
              expect(result.success?).to be true
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
            end
          end
        end

        context 'with pfr_statement and bank_form income' do
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/pension/full_document_set/'\
            'with_pfr_statement_and_bank_form.json'
            )
          end
          let(:incomeData) do
            array_including(
              incomeAmount: '3381034.5',
              incomeDocumentType: 'Reference form bank',
              incomeSource: 'Salary'
            )
          end
          let(:json) do
            hash_including(
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: [
                    hash_including(
                      listOfOptyContacts: hash_including(
                        optyContacts: [
                          hash_including(
                            listOfIncome: hash_including(income: incomeData)
                          )
                        ]
                      )
                    )
                  ]
                )
              )
            )
          end

          before do
            success_case_before
          end

          it 'returns success' do
            Timecop.travel(time) do
              result = call!
              expect(result.success?).to be true
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
            end
          end
        end

        context 'with pfr_certificate and ndfl2 income' do
          let(:time) { Time.zone.local(2020, 4, 8, 10, 11, 22) }
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/pension/full_document_set/'\
            'with_pfr_certificate_and_ndfl2.json'
            )
          end
          let(:incomeData) do
            array_including(
              incomeAmount: '217500.0',
              incomeDocumentType: 'Form 2',
              incomeSource: 'Salary'
            )
          end
          let(:json) do
            hash_including(
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: [
                    hash_including(
                      listOfOptyContacts: hash_including(
                        optyContacts: [
                          hash_including(
                            listOfIncome: hash_including(income: incomeData)
                          )
                        ]
                      )
                    )
                  ]
                )
              )
            )
          end

          before do
            success_case_before
          end

          it 'returns success' do
            Timecop.travel(time) do
              result = call!
              expect(result.success?).to be true
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
            end
          end
        end

        context 'with double ndfl2 income' do
          let(:time) { Time.zone.local(2020, 11, 5, 16, 0, 0) }
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/documents/ndfl2/when_double_ndfl2.json'
            )
          end
          let(:borrowerIncomeData) do
            array_including(
              incomeAmount: '60934.05',
              incomeDocumentType: 'Form 2',
              incomeSource: 'Salary'
            )
          end
          let(:json) do
            hash_including(
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: [
                    hash_including(
                      listOfOptyContacts: hash_including(
                        optyContacts: [
                          hash_including(
                            listOfIncome: hash_including(income: [])
                          ),
                          hash_including(
                            listOfIncome: hash_including(income: borrowerIncomeData)
                          )
                        ]
                      )
                    )
                  ]
                )
              )
            )
          end

          before do
            success_case_before
          end

          it 'returns success' do
            Timecop.travel(time) do
              result = call!
              expect(result.success?).to be true
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
            end
          end
        end

        context 'without job' do
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/pension/full_document_set/no_job.json'
            )
          end
          let(:incomeData) do
            array_including(
              incomeAmount: '300000000000000.0',
              incomeDocumentType: 'Reference form bank',
              incomeSource: 'Pension'
            )
          end
          let(:addressData) do
            array_including(
              # HINT: не все поля, выжимка
              hash_including(
                addressType: 'Residence',
                addressRegionCode: '0c5b2444-70a0-4932-980c-b4dc0d3f02b5',
                addressRegion: 'Москва г',
                addressStreet: 'Липовый парк ул'
              ),
              hash_including(
                addressType: 'Work',
                addressRegionCode: '0c5b2444-70a0-4932-980c-b4dc0d3f02b5',
                addressRegion: 'Москва г',
                addressStreet: 'Липовый парк ул'
              )
            )
          end
          let(:json) do
            hash_including(
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: [
                    hash_including(
                      listOfOptyContacts: hash_including(
                        optyContacts: [
                          hash_including(
                            listOfIncome: hash_including(income: incomeData),
                            listOfContactAddress: hash_including(contactAddress: addressData)
                          )
                        ]
                      )
                    )
                  ]
                )
              )
            )
          end

          before do
            success_case_before
          end

          it 'returns success' do
            Timecop.travel(time) do
              result = call!
              expect(result.success?).to be true
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
            end
          end
        end
      end

      context 'with bpm_errors in documents' do
        let(:event_logger_service) { double }
        let(:context_id) { data[:params][:context][:request_id] }
        let(:data) do
          Tests::Helpers.parse_json_file(
            'spec/fixtures/messages/convert/documents/with_bpm_errors.json'
          )
        end

        before do
          error_case_before
        end

        xit 'returns success' do
          Timecop.travel(time) do
            result = call!
            expect(result.success?).to be true
          end
        end
      end

      context 'with external checks' do
        let(:bpm_service) { double }
        let(:event_logger_service) { double }

        before do
          success_case_before
        end

        context 'when checks failed' do
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/external_checks.json'
            )
          end
          let(:expected_opty_comment) do
            'Ошибка1;Ошибка2;Ошибка3'
          end
          # HINT: по идее, на этот комментарий о создателе бы отдельный тест...
          let(:partner_comment) do
            'Менеджер партнера: rozinov_ma@tkbbank.ru, email: rozinov_ma@tkbbank.ru'
          end
          let(:json) do
            {
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: array_including(
                    hash_including(optyComment: including(expected_opty_comment, partner_comment))
                  )
                )
              )
            }
          end

          it 'returns filled optyComment' do
            Timecop.travel(time) do
              result = call!
              expect(result).to be_success
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
              expect(event_logger_service).to have_received(:send_event).exactly(2).times
            end
          end
        end
      end

      context 'with ndfl2' do
        let(:time) { Time.zone.local(2020, 2, 15, 10, 11, 22) }
        let(:bpm_service) { double }
        let(:event_logger_service) { double }
        let(:context_id) { data[:params][:context][:request_id] }

        before do
          success_case_before
        end

        context 'with bpm warnings' do
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/documents/ndfl2/with_bpm_warnings.json'
            )
          end
          let(:json) do
            {
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: array_including(
                    hash_including(optyComment: include('ВОЛКОВ АЛЕКСАНДР ИВАНОВИЧ: Message 32404'))
                  )
                )
              )
            }
          end

          it 'returns success' do
            Timecop.travel(time) do
              result = call!
              expect(result.success?).to be true
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
            end
          end
        end

        context 'when passport data mismatch' do
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/documents/ndfl2/when_passport_data_mismatch.json'
            )
          end
          let(:comment) do
            'ВОЛКОВ АЛЕКСАНДР ИВАНОВИЧ: Принести на сделку 2-НДФЛ за 2019, 2020 год '\
          'с корректными паспортными данными'
          end
          let(:json) do
            {
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: array_including(
                    hash_including(optyComment: include(comment))
                  )
                )
              )
            }
          end

          it 'returns success' do
            Timecop.travel(time) do
              result = call!
              expect(result.success?).to be true
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
            end
          end
        end

        context 'when employer phone is blank' do
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/documents/ndfl2/when_employer_phone_blank.json'
            )
          end
          let(:comment) do
            'ВОЛКОВ АЛЕКСАНДР ИВАНОВИЧ: Принести на сделку 2-НДФЛ за 2019 год '\
          'с заполненным телефоном работодателя'
          end
          let(:json) do
            {
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: array_including(
                    hash_including(optyComment: include(comment))
                  )
                )
              )
            }
          end

          it 'returns success' do
            Timecop.travel(time) do
              result = call!
              expect(result.success?).to be true
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
            end
          end
        end

        context 'when employer phone is present' do
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/documents/ndfl2/when_employer_phone_present.json'
            )
          end
          let(:comment) do
            'ВОЛКОВ АЛЕКСАНДР ИВАНОВИЧ: Принести на сделку 2-НДФЛ за 2019 год '\
          'с заполненным телефоном работодателя'
          end
          let(:json) do
            {
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: array_including(
                    hash_including(optyComment: exclude(comment))
                  )
                )
              )
            }
          end

          it 'returns success' do
            Timecop.travel(time) do
              result = call!
              expect(result.success?).to be true
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
            end
          end
        end
      end

      context 'with bank form' do
        # TODO(khataev): убрать дублирование даблов
        let(:time) { Time.zone.local(2020, 2, 15, 10, 11, 22) }
        let(:bpm_service) { double }
        let(:event_logger_service) { double }
        let(:context_id) { data[:params][:context][:request_id] }

        before do
          success_case_before
        end

        context 'when employer phone is blank' do
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/documents/bank_form/when_employer_phone_blank.json'
            )
          end
          let(:comment) do
            'ВОЛКОВ АЛЕКСАНДР ИВАНОВИЧ: Принести на сделку ПФБ '\
          'с заполненным телефоном работодателя'
          end
          let(:json) do
            {
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: array_including(
                    hash_including(optyComment: include(comment))
                  )
                )
              )
            }
          end

          it 'returns success' do
            Timecop.travel(time) do
              result = call!
              expect(result.success?).to be true
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
            end
          end
        end

        context 'when employer phone present' do
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/documents/bank_form/when_employer_phone_present.json'
            )
          end
          let(:comment) do
            'ВОЛКОВ АЛЕКСАНДР ИВАНОВИЧ: Принести на сделку ПФБ '\
          'с заполненным телефоном работодателя'
          end
          let(:json) do
            {
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: array_including(
                    hash_including(optyComment: exclude(comment))
                  )
                )
              )
            }
          end

          it 'returns success' do
            Timecop.travel(time) do
              result = call!
              expect(result.success?).to be true
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
            end
          end
        end
      end

      context 'with adapted credit_term' do
        let(:time) { Time.zone.local(2020, 5, 26, 10, 11, 22) }
        let(:bpm_service) { double }
        let(:event_logger_service) { double }
        let(:context_id) { data[:params][:context][:request_id] }
        let(:data) do
          Tests::Helpers.parse_json_file(
            'spec/fixtures/messages/convert/adapted_credit_term.json'
          )
        end
        let(:json) do
          {
            request: hash_including(
              listOfOptInfo: hash_including(
                opty: array_including(
                  hash_including(
                    optyComment: include(I18n.t('serializers.request.adapted_credit_term_comment'))
                  )
                )
              )
            )
          }
        end

        before do
          success_case_before
        end

        it 'adds adaptation comment' do
          Timecop.travel(time) do
            result = call!
            expect(result.success?).to be true
            expect(bpm_service)
              .to have_received(:send_convert_done).with(data[:id], json, routing_key)
          end
        end
      end

      context 'с поручителем в заявке' do
        let(:time) { Time.zone.local(2020, 12, 20, 10, 11, 22) }
        let(:bpm_service) { double }
        let(:event_logger_service) { double }
        let(:context_id) { data[:params][:context][:request_id] }
        let(:data) do
          Tests::Helpers.parse_json_file(
            'spec/fixtures/messages/convert/with_guarantor.json'
          )
        end
        let(:json) do
          {
            request: hash_including(
              listOfOptInfo: hash_including(
                opty: array_including(
                  hash_including(
                    listOfOptyContacts: hash_including(
                      optyContacts: array_including(
                        hash_including(
                          contApplicantType: 'Созаемщик'
                        )
                      )
                    )
                  )
                )
              )
            )
          }
        end

        let(:json_wrong) do
          {
            request: hash_including(
              listOfOptInfo: hash_including(
                opty: array_including(
                  hash_including(
                    listOfOptyContacts: hash_including(
                      optyContacts: array_including(
                        hash_including(
                          contApplicantType: 'Поручитель'
                        )
                      )
                    )
                  )
                )
              )
            )
          }
        end

        before do
          success_case_before
        end

        it 'меняем тип поручитель на созаемщик' do
          Timecop.travel(time) do
            result = call!
            expect(result.success?).to be true
            expect(bpm_service)
              .to have_received(:send_convert_done).with(data[:id], json, routing_key)
          end
        end

        it 'отсутствует тип поручитель' do
          Timecop.travel(time) do
            result = call!
            expect(result.success?).to be true
            expect(bpm_service)
              .not_to have_received(:send_convert_done).with(data[:id], json_wrong, routing_key)
          end
        end
      end

      context 'with state_support program and profitable tariff' do
        let(:time) { Time.zone.local(2020, 6, 19, 10, 11, 22) }
        let(:bpm_service) { double }
        let(:event_logger_service) { double }
        let(:context_id) { data[:params][:context][:request_id] }
        let(:data) do
          Tests::Helpers.parse_json_file(
            'spec/fixtures/messages/convert/options/one_time_payment.json'
          )
        end
        let(:json) do
          {
            request: hash_including(
              listOfOptInfo: hash_including(
                opty: array_including(
                  hash_including(
                    listOfOptyOptions: hash_including(
                      optyOptions: array_including(
                        name: 'Единовременный платеж за снижение ставки'
                      )
                    )
                  )
                )
              )
            )
          }
        end

        before do
          success_case_before
        end

        it 'adds adaptation comment' do
          Timecop.travel(time) do
            result = call!
            expect(result.success?).to be true
            expect(bpm_service)
              .to have_received(:send_convert_done).with(data[:id], json, routing_key)
          end
        end
      end

      context 'when other request comments cases' do
        let(:bpm_service) { double }
        let(:event_logger_service) { double }
        let(:context_id) { data[:params][:context][:request_id] }

        before do
          success_case_before
        end

        context 'when simple documents' do
          let(:time) { Time.zone.local(2020, 7, 21, 10, 11, 22) }
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/comments/simple_documents.json'
            )
          end
          let(:comment1) do
            'Принести на сделку 2-НДФЛ за 2019 год с заполненным телефоном работодателя'
          end
          let(:comment2) do
            'Принести на сделку ПФБ с заполненным телефоном работодателя'
          end
          let(:json) do
            {
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: array_including(
                    hash_including(optyComment: exclude(comment1, comment2))
                  )
                )
              )
            }
          end

          it 'returns success' do
            Timecop.travel(time) do
              result = call!
              expect(result.success?).to be true
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
            end
          end
        end
      end
    end

    context 'with incomplete jobs' do
      let(:time) { Time.zone.local(2020, 6, 19, 10, 11, 22) }
      let(:bpm_service) { double }
      let(:event_logger_service) { double }
      let(:context_id) { data[:params][:context][:request_id] }

      before do
        success_case_before
      end

      describe 'когда пенсия' do
        RSpec.shared_examples 'success pension example' do
          let(:time) { Time.zone.local(2020, 9, 9, 10, 11, 22) }
          let(:json) do
            hash_including(
              request: hash_including(
                listOfOptInfo: hash_including(
                  opty: [
                    hash_including(
                      listOfOptyContacts: hash_including(
                        optyContacts: [
                          hash_including(
                            listOfContactEmpH: hash_including(
                              contactEmpH: [employments1Data]
                            )
                          ),
                          hash_including(
                            listOfContactEmpH: hash_including(
                              contactEmpH: [employments2Data]
                            )
                          )
                        ]
                      )
                    )
                  ]
                )
              )
            )
          end

          it 'returns success' do
            Timecop.travel(time) do
              result = call!
              expect(result.success?).to be true
              expect(bpm_service)
                .to have_received(:send_convert_done).with(data[:id], json, routing_key)
            end
          end
        end

        context 'оказывается в будущем, вычисляем дату выхода, как год назад' do
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/incomplete_jobs/03.json'
            )
          end
          let(:employments1Data) do
            {
              empHEndDate: nil,
              empHFirmINN: nil,
              empHSICCode: 'Other',
              empHEmployer: '-',
              empHStartDate: '09/09/2019',
              ownershipType: 'Other',
              empHOccupation: 'Other',
              empHEmploymentType: 'Pensioner',
              empHFirmEmplyeeCount: 'Less 20',
              empHFirmDirectionType: 'Пенсия',
              empHEmployerDescription: '-'
            }
          end
          let(:employments2Data) do
            {
              empHEndDate: nil,
              empHFirmINN: nil,
              empHSICCode: 'Other',
              empHEmployer: '-',
              empHStartDate: '09/09/2019',
              ownershipType: 'Other',
              empHOccupation: 'Other',
              empHEmploymentType: 'Pensioner',
              empHFirmEmplyeeCount: 'Less 20',
              empHFirmDirectionType: 'Пенсия',
              empHEmployerDescription: '-'
            }
          end

          it_behaves_like 'success pension example'
        end

        context 'дата выхода на пенсию не указана, прибавляем пенсионный возраст к дню рождению' do
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/incomplete_jobs/05.json'
            )
          end
          let(:employments1Data) do
            {
              empHEndDate: nil,
              empHFirmINN: nil,
              empHSICCode: 'Other',
              empHEmployer: '-',
              empHStartDate: '10/20/2016',
              ownershipType: 'Other',
              empHOccupation: 'Other',
              empHEmploymentType: 'Pensioner',
              empHFirmEmplyeeCount: 'Less 20',
              empHFirmDirectionType: 'Пенсия',
              empHEmployerDescription: '-'
            }
          end
          let(:employments2Data) do
            {
              empHEndDate: nil,
              empHFirmINN: nil,
              empHSICCode: 'Other',
              empHEmployer: '-',
              empHStartDate: '10/20/2016',
              ownershipType: 'Other',
              empHOccupation: 'Other',
              empHEmploymentType: 'Pensioner',
              empHFirmEmplyeeCount: 'Less 20',
              empHFirmDirectionType: 'Пенсия',
              empHEmployerDescription: '-'
            }
          end

          it_behaves_like 'success pension example'
        end

        context 'when retirement date is specified in pfr statement' do
          let(:data) do
            Tests::Helpers.parse_json_file(
              'spec/fixtures/messages/convert/incomplete_jobs/04.json'
            )
          end
          let(:employments1Data) do
            {
              empHEndDate: nil,
              empHFirmINN: nil,
              empHSICCode: 'Other',
              empHEmployer: '-',
              empHStartDate: '09/08/2020', # from pfr cert
              ownershipType: 'Other',
              empHOccupation: 'Other',
              empHEmploymentType: 'Pensioner',
              empHFirmEmplyeeCount: 'Less 20',
              empHFirmDirectionType: 'Пенсия',
              empHEmployerDescription: '-'
            }
          end
          let(:employments2Data) do
            {
              empHEndDate: nil,
              empHFirmINN: nil,
              empHSICCode: 'Other',
              empHEmployer: '-',
              empHStartDate: '09/08/2020', # from pfr cert
              ownershipType: 'Other',
              empHOccupation: 'Other',
              empHEmploymentType: 'Pensioner',
              empHFirmEmplyeeCount: 'Less 20',
              empHFirmDirectionType: 'Пенсия',
              empHEmployerDescription: '-'
            }
          end

          it_behaves_like 'success pension example'
        end
      end
    end

    context 'with work phones' do
      let(:bpm_service) { double }
      let(:event_logger_service) { double }
      let(:context_id) { data[:params][:context][:request_id] }

      context 'when work phone present' do
        let(:time) { Time.zone.local(2020, 7, 22, 10, 11, 22) }
        let(:data) do
          Tests::Helpers.parse_json_file(
            'spec/fixtures/messages/convert/work_phones/present.json'
          )
        end
        let(:json) do
          {
            request: kind_of(Hash)
          }
        end

        before do
          success_case_before
        end

        it 'adds adaptation comment' do
          Timecop.travel(time) do
            result = call!
            expect(result.success?).to be true
            expect(bpm_service)
              .to have_received(:send_convert_done).with(data[:id], json, routing_key)
          end
        end
      end
    end
  end
  
end
