# frozen_string_literal: true

# missile - ракета
# torpedo - торпеда
# hold - трюм
# crane - кран

# корабль
class Ship
  attr_accessor :tonnage, :speed
end

# подводная лодка
class Submarine < Ship
  attr_accessor :max_depth
end

# атомную подводную лодку (ракеты, торпеды);
class AtomicSubmarine < Submarine
  attr_accessor :missile, :torpedo
end

# надводный корабль
class SurfaceVessel < Ship
  attr_accessor :displacement
end

# сухогруз для перевоза зерна (грузовой трюм, кран);
class DryCargoShip < SurfaceVessel
  attr_accessor :hold, :crane
end

# контейнеровоз (кран);
class ContainerShip < SurfaceVessel
  attr_accessor :crane
end

# нефтяной танкер (грузовой трюм);
class Tanker < SurfaceVessel
  attr_accessor :hold
end

# ракетный крейсер (ракеты);
class Cruiser < SurfaceVessel
  attr_accessor :missile
end

# военный транспорт (ракеты, грузовой трюм, кран).
class Transport < SurfaceVessel
  attr_accessor :missile, :hold, :crane
end

ship = Transport.new

ship.tonnage = 2000
ship.speed = 120
ship.displacement = 1000
ship.missile = 13
ship.hold = 200
ship.crane = true

p ship
