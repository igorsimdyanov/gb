class Request::Operations::Create < Trailblazer::Operation
  step :create_request
  step :send_start_event
  step :send_initialize
  step :send_success_event

  def create_request(options)
    options['model'] = Request.create(options['params']['attributes'])
  end

  def send_start_event(options)
    EventLogger::Operations::SendEvent.call(
      'object' => options['model'],
      'event' => 'irs.request_create.start'
    ).success?
  end

  def send_initialize(options)
    Request::Bpm::Messages::Operations::Initialize.call(
      id: options['model'].id
    ).success?
  end

  def send_success_event(options)
    EventLogger::Operations::SendEvent.call(
      'object' => options['model'],
      'event' => 'irs.request_create.success'
    ).success?
  end
end
