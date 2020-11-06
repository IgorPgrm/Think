require_relative 'module'
require_relative 'instance_counter'

class Train
  include ModuleManufacturer::InstanceMethods
  include InstanceCounter
  attr_reader :number, :type, :carriages, :current_station, :next_station, :prev_station, :speed
  attr_accessor :route

  @@all_trains = []
  NUMBERREGEX = /^[a-z а-я\d]{3}-?[а-я a-z\d]{2}$/i.freeze

  def initialize(number, type)
    @number = number
    validate!
    @type = type
    @speed = 0
    @carriages = []
    add_train_to_all self
  end

  def validate?
    validate!
  rescue StandardError
    false
  end

  def show_info
    puts "class #{self.class}"
  end

  def speed_up
    @speed += 1
  end

  def speed_down
    @speed -= 1 if @speed.positive?
  end

  def each_carriage
    @carriages.each { |c| yield(c) } if block_given?
  end

  def stop
    @speed = 0
  end

  def add_carriage(carriage)
    @carriages.push carriage if @speed.zero? && type == carriage.type
  end

  def remove_carriage(carriage)
    @carriages.delete carriage if @speed.zero?
  end

  def add_route(route)
    @route = route
    @current_station = route.stations.first
    @current_station.add_train(self)
  end

  def remove_route
    @route = nil
    @current_station.remove_train(self)
  end

  def next_station
    @route.stations[@route.stations.index(@current_station) + 1] unless last_station?
  end

  def prev_station
    @route.stations[@route.stations.index(@current_station) - 1] unless first_station?
  end

  def last_station?
    @current_station == @route.stations.last
  end

  def first_station?
    @current_station == @route.stations.first
  end

  def move_forvard
    unless last_station?
      @current_station.remove_train(self)
      @current_station = next_station
      @current_station.add_train(self)
    end
  end

  def move_back
    unless first_station?
      @current_station.remove_train(self)
      @current_station = prev_station
      @current_station.add_train(self)
    end
  end

  def self.find(param)
    if @@all_trains.any?
      @@all_trains.each do |train|
        return train if train.number == param
      end
    end
    nil
  end

  private

  def add_train_to_all(train)
    @@all_trains << train
  end

  protected

  def validate!
    raise ArgumentError, 'Номер не может быть меньше 5 символов' if number.length < 5
    raise ArgumentError, 'Неправильно задан номер. Формат 123-45 или АБВ-ГД' if NUMBERREGEX !~ number

    true
  end
end
