require_relative 'battle_field/field.rb'
require_relative 'battle_field/chess.rb'
require_relative 'battle_field/ship.rb'

class BattleField
  attr_accessor :size, :fields

  def initialize(size: Chess::SIZE)
    @size = size
    @fields = yield(size) if block_given?
    @fields ||= Array.new(size) do |y|
      Array.new(size) do |x|
        Field.new(x: Chess::X[x], y: y + 1)
      end
    end
  end

  def to_s
    lines.join("\n")
  end

  private

  def lines
    fields.map do |line|
      line.map(&:to_s).join ' '
    end
  end
end
