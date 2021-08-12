require 'json'

params = JSON.parse(File.read('person.json'))
# p params
puts params['first_name']
puts params['last_name']
