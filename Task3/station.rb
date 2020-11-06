require_relative 'instance_counter'

class Station
  include InstanceCounter
  attr_reader :title, :trains
  @@all_station = []
  STATIONREGEXP = /^[A-Z А-Я]+[а-я \w]+-?[\d]?[А-Я а-я \w 0-9]*/

  def initialize(title)
    @title = title
    validate!
    @trains = []
    add_station(self)
    register_instance
  end

  def validate?
    validate!
  rescue
    false
  end

  def add_train train
    @trains << train
  end

  def remove_train train
    @trains.delete(train)
  end

  def show_trains_on_station
    @trains.each { |train| puts "\t\t #{train.number}\t| #{train.type}\t| #{train.carriages}" }
  end

  def show_trains_on_station_by_type type #отображение по типу
    @trains.each { |train| puts "\t\t #{train.number}\t| #{train.type}\t| #{train.carriages}"  if train.type == type}
  end

  def each_train(&block)
    if block_given?
      @trains.each { |t| yield(t) }
    end
  end

  def self.all
    @@all_station
  end

  protected
  def validate!
    raise ArgumentError, "Неверный формат. Формат: 'Москва', 'Москва-2', 'Йошкар-ола'" if title !~ STATIONREGEXP
    raise ArgumentError, "Название должно быть минимум 3 символа" if title.length < 3
  end

  def add_station station
    @@all_station << station
  end
end