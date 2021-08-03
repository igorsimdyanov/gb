# frozen_string_literal: true

require_relative 'lib/parser'

parser = Parser.new(PriceParsing.new)
puts 'Parsing price'
p parser.parse('Букет роз 2500, букет тюльпанов 1000, упаковка, доставка')

puts 'Parsing news'
parser.job = NewsParsing.new
p parser.parse('Вечерние новости. Продажи чего то упали. Прошли выборы. Цены на цветы подскачили из новостей.')
