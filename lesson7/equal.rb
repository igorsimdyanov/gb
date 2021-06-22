=begin
number = 1
str = 'Hello, world!'

fst = 'первый'
snd = 'второй'

fst, snd = snd, fst

fst = 'hello'
snd = 'world'
thd = '!'

fst, snd, thd = 'hello', 'world', '!'
puts fst
puts snd
puts thd

fst, snd, thd = 'hello, world!'
p fst # hello, world!
p snd # nil
p thd # nil

fst, snd, thd = ['hello', 'world', '!']
p fst
p snd
p thd

# fst, snd, thd = obj.method

fst, snd = ['hello', 'world', '!']
p fst
p snd

fst, (f, s), thd = ['hello', 'world', '!']
p fst # hello
p f   # world
p s   # nil
p thd # !

fst, (f, s), thd = ['hello', ['world', 'ruby'], '!']
p fst # hello
p f   # world
p s   # ruby
p thd # !

# *
fst, snd, thd = 'hello', ['world', '!']
p fst # hello
p snd # ["world", "!"]
p thd # nil

fst, snd, thd = 'hello', *['world', '!']
p fst # hello
p snd # "world"
p thd # "!"

arr = [1, 2, 3]
def method(fst, snd, thd)
method(*arr)

fst, *snd = ['Hello', 'world', '!']
p fst # "hello"
p snd # ["world", "!"]
=end

*fst, snd = ['Hello', 'world', '!']
p fst # ["hello", "world"]
p snd # "!"









