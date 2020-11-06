require_relative 'train'

class PassengerTrain < Train
  include InstanceCounter
  @subclass_instance = 0
  attr_accessor :number_seats

  def initialize(number)
    super(number, :passenger)
    register_instance
  end
end
