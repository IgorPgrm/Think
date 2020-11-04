require_relative 'carriage'

class CargoCarriage < Carriage
  attr_reader :total_volume, :free_volume, :busy_volume

  def initialize(volume)
    super(:cargo)
    @total_volume = volume
    @free_volume = volume
    @busy_volume = 0
  end

  def load volume
    raise ArgumentError, "В вагоне нет места, он загружен" if @busy_volume == @total_volume
    raise ArgumentError, "Большой объём для размещения! Укажите меньший объём" if (@busy_volume+volume > @total_volume)
    @free_volume -= volume
    @busy_volume += volume
  end

end