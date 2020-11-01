require_relative 'module'
require_relative 'instance_counter'

class Train
  include ModuleManufacturer::InstanceMethods
  include InstanceCounter
  attr_reader :number, :type, :carriages, :current_station, :next_station, :prev_station, :speed
  attr_accessor :route
  @@all_trains = []

  def initialize number, type
    @number = number
    @type = type
    @speed = 0
    @carriages = []
    add_train_to_all self
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

  def stop
    @speed = 0
  end

  def add_carriage(carriage)
    @carriages.push carriage if @speed.zero? && self.type == carriage.type
  end

  def remove_carriage(carriage)
    @carriages.delete carriage if @speed.zero?
  end

  def add_route route
    @route = route
    @current_station = route.stations.first
    @current_station.add_train(self)
  end

  def remove_route
    @route = nil
    @current_station.remove_train(self)
  end

  def next_station
    @route.stations[@route.stations.index(@current_station) + 1] unless is_last_station?
  end

  def prev_station
    @route.stations[@route.stations.index(@current_station) - 1] unless is_first_station?
  end

  def is_last_station?
    @current_station == @route.stations.last
  end

  def is_first_station?
    @current_station == @route.stations.first
  end

  def move_forvard
    unless is_last_station?
      @current_station.remove_train(self)
      @current_station = next_station
      @current_station.add_train(self)
    end
  end

  def move_back
    unless is_first_station?
      @current_station.remove_train(self)
      @current_station = prev_station
      @current_station.add_train(self)
    end
  end

  def self.find param
    if @@all_trains.any?
      @@all_trains.each do |train|
        if train.number == param
          return train
        end
      end
    end
    return nil
  end

  private
  def add_train_to_all train
    @@all_trains << train
  end
end
