# frozen_string_literal: true

# Класс шахматной фигуры
# @option opts [Symbol] :color Цвет :white или :black
# @option opts [Symbol] :type Тип фигуры :pawn, :king, :queen, :bishop, :knight, :rook
#
# @example
#
#   pawn = Chess.new(type: :pawn, color: :black)
#
class Chess
  attr_accessor :color, :type

  COLORS = %i[white black].freeze
  TYPES = %i[pawn king queen bishop knight rook].freeze

  COLOR_ERROR = 'Введен недопустимый цвет, разрешено :white и :black'
  TYPE_ERROR = 'Введен недопустимый тип фигуры, '\
               'разрешено :pawn, :king, :queen, :bishop, :knight, :rook'

  def initialize(color: :white, type: :pawn)
    raise COLOR_ERROR unless COLORS.include?(color)
    raise TYPE_ERROR unless TYPES.include?(type)

    @color = color
    @type = type
  end

  TYPES.each do |name|
    define_method "#{name}?" do
      type == name
    end
  end

  COLORS.each do |color|
    define_method "#{color}?" do
      color == name
    end
  end
end

FORMAT = 'Цвет: %s, фигура: %s'

fst = Chess.new
puts format(FORMAT, fst.color, fst.type)
p fst.pawn?
p fst.king?

snd = Chess.new(type: :bishop, color: :black)
puts format(FORMAT, snd.color, snd.type)
p snd.pawn?
p snd.bishop?

thd = Chess.new(type: :warrior, color: :red)
puts format(FORMAT, thd.color, thd.type)
