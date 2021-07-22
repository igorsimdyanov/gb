# frozen_string_literal: true

en_colors = %w[red orange yellow green gray indigo violet].map(&:to_sym)
ru_colors = %w[красный оранжевый желтый зеленый голубой синий фиолетовый]
p en_colors.zip(ru_colors).to_h
