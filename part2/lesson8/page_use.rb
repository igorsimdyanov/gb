%w[page about news photo_catalog].each do |file|
  require_relative file
end

about = About.new

about.title = 'О нас'
about.body = 'Вы можете обнаружить нас по адресу'
about.keywords = ['О нас', 'Адреса', 'Телефоны']
about.phones = ['+7 926 2423432', '+7 920 2344234']
about.address = 'Москва, Ленина 7'

p about

page = Page.new

page.title = 'О нас'
page.body = 'Вы можете обнаружить нас по адресу'
page.keywords = ['О нас', 'Адреса', 'Телефоны']
# page.phones = ['+7 926 2423432', '+7 920 2344234']
# page.address = 'Москва, Ленина 7'
p page
