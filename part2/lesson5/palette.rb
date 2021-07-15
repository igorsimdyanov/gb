class Palette
  def initialize(colors = [])
    @colors = colors # []
    @colors = yield if block_given?
  end

  def each
    @colors.each { |c| yield c }
  end
end

colors = %w[красный оранжевый желтый]

pal = Palette.new { %w[красный оранжевый желтый] }
pal.each { |color| puts color }

pal = Palette.new(%w[красный оранжевый желтый])
pal.each { |color| puts color }