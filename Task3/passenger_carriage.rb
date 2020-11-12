require_relative 'carriage'
require_relative 'validation_module'

class PassengerCarriage < Carriage
  include Validation
  attr_reader :type, :total_count, :places, :free_places, :busy_places

  validate :type, :type_of, Symbol
  validate :total_count, :positive

  def initialize(total_count)
    @type = :passenger
    super(@type)
    @total_count = total_count
    @free_places = total_count
    @busy_places = 0
    @places = []
    validate!
    @total_count.times { @places << :free } unless @total_count.zero?
  end

  def add_passenger
    raise ArgumentError, 'Нет свободных мест' if @free_places.zero?

    @places.each_with_index do |place, index|
      next unless place == :free

      @places[index] = :passenger
      @busy_places += 1
      @free_places = @total_count - @busy_places
      break
    end
  end
end
