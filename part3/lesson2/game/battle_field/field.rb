class BattleField
  class Field
    attr_accessor :x, :y

    def initialize(x:, y:)
      @x = x
      @y = y
    end

    def to_s
      format("%4s", "#{x}:#{y}")
    end
  end
end
