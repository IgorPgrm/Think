require_relative 'carriage'

class PassengerCarriage < Carriage
  attr_reader :total_count, :places, :free_places

  def initialize(residue_count)
    @total_count = residue_count
    @free_places = residue_count
    @places = []
    super(:passenger)
    @total_count.times { @places << :free } unless @total_count == 0
  end

  def add_passenger
    raise ArgumentError, "Нет свободных мест" if @free_places.zero?
    @places.each_with_index do |place, index|
      if place == :free
        @places[index] = :passenger
        @free_places -= 1
        break
      end
    end
  end

end