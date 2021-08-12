class Rainbow
  include Enumerable

  COLORS = %w[красный оранжевый желтый
              зеленый голубой синий фиолетовый]

  def each
    COLORS.each { |x| yield x }
  end
end
