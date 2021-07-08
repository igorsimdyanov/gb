# def my_loop
#   n = 0
#   yield n += 1
#   yield n += 1
#   yield n += 1
# end

# my_loop { |i| puts "#{i} Hello, world!" }

# def greeting(name)
#   yield 'Hello', name
# end

# greeting('world') { |fst, snd| puts "#{fst}, #{snd}!" }

def greeting(name)
  yield 'Hello', 'Ruby', '!'
end

greeting('world') { |fst, snd| puts "#{fst}, #{snd}!" }

greeting('world') do |fst, snd, thd, fth|
  p fst
  p snd
  p thd
  p fth
end

greeting('world') do
  p 'hello'
end
