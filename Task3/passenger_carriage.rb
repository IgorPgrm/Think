require_relative 'carriage'

class PassengerCarriage < Carriage
  def initialize
    super(:passanger)
  end

  def show_info
    puts "class PassangerCarriage"
  end
end