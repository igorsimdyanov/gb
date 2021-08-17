# frozen_string_literal: true

require_relative 'lib/pages'

about = About.new
about.title = 'О нас'
about.body = 'Вы сможете обнаружить нас по адресам'
about.phones = ['+7 920 4567722', '+7 920 4567733']
about.address = '191036, Санкт-Петербург, ул. Гончарная, дом 20, пом. 7Н'

seo = Seo.new
seo.title = about.title
seo.description = "Адрес: #{about.address}"
seo.keywords = ['О нас', 'Адреса', 'Телефоны']

about.seo = seo

p about
