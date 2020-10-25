class Route
  attr_reader :first_station, :last_station, :stations

  def initialize (first_station, last_station)
    @first_station, @last_station = first_station, last_station
    @stations = [ @first_station, @last_station]
  end

  def show_route
    @stations.each.with_index(1) { | station, index | puts "#{index}) - #{station}"}
  end

  def add_station station
    @stations.insert(-2,station) unless present_station_in_route? station
  end

  def del_station station
    @stations.delete(station) if present_station_in_route? station
  end

  def present_station_in_route? station
    @stations.include? station
  end

end