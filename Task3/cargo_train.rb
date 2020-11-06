# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  include InstanceCounter
  def initialize(number)
    super(number, :cargo)
    register_instance
  end
end
