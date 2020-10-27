require_relative 'carriage'

class CargoCarriage < Carriage
  attr_accessor :capacity, :volume #масса полезного груза вагона
  CARGO_CAPACITY = 71_000 # максимально перевозимая масса
  CARGO_VOLUME = 88 # объём в кубах
  CARGO_MASS = 24_000 #масса вагона 24 т.

  def initialize
    super(:cargo)
    capacity = 0
    volume = 0
  end

  def load mass=0, volume=0

  end

end