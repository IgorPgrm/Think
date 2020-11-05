require_relative 'carriage'

class PassengerCarriage < Carriage
  attr_reader :total_count, :places, :free_places, :busy_places

  def initialize(total_count)
    @total_count = total_count
    @free_places = total_count
    @busy_places = 0
    @places = []
    super(:passenger)
    @total_count.times { @places << :free } unless @total_count == 0
  end

  def add_passenger
    raise ArgumentError, "Нет свободных мест" if @free_places.zero?
    @places.each_with_index do |place, index|
      if place == :free
        @places[index] = :passenger
        @busy_places += 1
        @free_places = @total_count - @busy_places
        break
      end
    end
  end

end