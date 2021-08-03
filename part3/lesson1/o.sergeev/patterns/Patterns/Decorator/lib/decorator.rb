# frozen_string_literal: true

# class Package
class Package
  def operation
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# class CylophaneBag
class CylophaneBag < Package
  def operation
    self.class.name
  end
end

# class Packer
class Packer < Package
  attr_accessor :component

  def initialize(component)
    @component = component
  end

  def operation
    @component.operation
  end
end

# class CardboardBox
class CardboardBox < Packer
  def operation
    "#{self.class.name} #{@component.operation}"
  end
end

# class PlywoodBox
class PlywoodBox < Packer
  def operation
    "#{self.class.name} #{@component.operation}"
  end
end

def pack(component)
  component.operation
end
