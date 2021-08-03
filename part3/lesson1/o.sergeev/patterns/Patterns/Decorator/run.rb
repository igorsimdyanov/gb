# frozen_string_literal: true

require_relative 'lib/decorator'

cylophane_bag = CylophaneBag.new
print "By default, your postal item will be packed in: #{pack(cylophane_bag)}"
puts "\n\n"
cardboard_box = CardboardBox.new(cylophane_bag)
plywood_box = PlywoodBox.new(cardboard_box)
print "Your postal item will be total packed in: '#{pack(plywood_box)}'"
puts "\n\n"
