# frozen_string_literal: true

# Open standart class Hash
class Hash
  def to_json(hash_object = self, _result = '')
    arr = hash_object.map do |key, value|
      "\"#{key}\":" + to_json_value(value)
    end
    "{#{arr.join(',')}}"
  end

  def to_json_value(value)
    case value
    when Symbol
      "\"#{value}\""
    when String
      "\"#{value}\""
    when Integer
      value.to_s
    when Hash
      to_json(value, '')
    end
  end
end

h = {
  fst: :hello,
  snd: :world,
  object: {
    id: 3456,
    name: 'Заголовок'
  }
}

puts h.to_json
