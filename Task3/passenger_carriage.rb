require_relative 'carriage'

class PassangerCarriage < Carriage
  attr_accessor :number_seats
  attr_reader :residue_number

  def initialize
    super(:passanger)
    @residue_number = 54 #свободные места
    @number_seats = 0 #занято мест
  end
end