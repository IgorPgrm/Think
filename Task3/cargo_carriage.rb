# frozen_string_literal: true

require_relative 'carriage'
require_relative 'validation_module'

class CargoCarriage < Carriage
  include Validation

  attr_reader :total_volume, :free_volume, :busy_volume

  validate :type, :type_of, Symbol
  validate :total_volume, :positive

  def initialize(volume)
    @type = :cargo
    super(@type)
    @total_volume = volume
    @free_volume = volume
    @busy_volume = 0
    validate!
  end

  def load(volume)
    raise ArgumentError, 'В вагоне нет места, он загружен' if @busy_volume == @total_volume
    raise ArgumentError, 'Большой объём для размещения! Укажите меньший объём' if @busy_volume + volume > @total_volume

    @free_volume -= volume
    @busy_volume += volume
  end
end
