require_relative 'instance_counter'

class Station
  include InstanceCounter
  attr_reader :title, :trains

  @@all_station = []
  STATIONREGEXP = /^[A-Z А-Я]+[а-я \w]+-?\d?[А-Я а-я \w 0-9]*/.freeze

  def initialize(title)
    @title = title
    validate!
    @trains = []
    add_station(self)
    register_instance
  end

  def validate?
    validate!
  rescue StandardError
    false
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

  def each_train
    @trains.each { |t| yield(t) } if block_given?
  end

  def self.all
    @@all_station
  end

  protected

  def validate!
    raise ArgumentError, "Неверный формат. Формат: 'Москва', 'Москва-2', 'Йошкар-ола'" if title !~ STATIONREGEXP
    raise ArgumentError, 'Название должно быть минимум 3 символа' if title.length < 3
  end

  def add_station(station)
    @@all_station << station
  end
end
