class Station
  include InstanceCounter
  attr_reader :title, :trains
  @@all_station = []

  def initialize(title)
    @title = title
    @trains = []
    add_station(self)
    register_instance
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

  def self.all
    @@all_station
  end

  private
  def add_station station
    @@all_station << station
  end
end