require_relative 'train'

class PassengerTrain < Train
  include InstanceCounter
  @subclass_instance = 0
  attr_accessor :number_seats
  PLACKART_NUMBER_SEATS = 54

  def initialize(number)
    super(number, :passenger)
    register_instance
  end
end