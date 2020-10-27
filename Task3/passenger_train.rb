require_relative 'train'

class PassengerTrain < Train
  attr_accessor :number_seats
  PLACKART_NUMBER_SEATS = 54

  def initialize(number)
    super(number, :passenger)
  end
end