require_relative 'instance_counter'
require_relative 'validation_module'

class Station
  include InstanceCounter
  include Validation

  attr_reader :title, :trains

  validate :title, :type_of, String
  validate :title, :length, min: 3, max: 20
  validate :title, :format, /^[A-Z А-Я]+[а-я \w]+-?\d?[А-Я а-я \w 0-9]*/.freeze

  @@all_station = []

  def initialize(title)
    @title = title
    validate!
    @trains = []
    add_station(self)
    register_instance
  end

  def add_train(train)
    @trains << train
  end

  def remove_train(train)
    @trains.delete(train)
  end

  def show_trains_on_station
    @trains.each { |train| puts "\t\t #{train.number}\t| #{train.type}\t| #{train.carriages}" }
  end

  def show_trains_on_station_by_type(type)
    @trains.each { |train| puts "\t\t #{train.number}\t| #{train.type}\t| #{train.carriages}" if train.type == type }
  end

  def each_train(&block)
    @trains.each(&block) if block_given?
  end

  def self.all
    @@all_station
  end

  protected

  def add_station(station)
    @@all_station << station
  end
end
