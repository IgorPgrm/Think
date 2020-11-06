class Route
  include InstanceCounter
  attr_reader :stations, :title

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @title = "#{first_station.title} ->  #{last_station.title}"
    @stations = [@first_station, @last_station]
    register_instance
  end

  def show_route
    @stations.each.with_index(1) do |station, index|
      if @stations.last == station
        puts "#{index}) #{station.title}"
      else
        print "#{index}) #{station.title} -> "
      end
    end
    "\n"
  end

  def add_station(station)
    @stations.insert(-2, station) unless present_station_in_route? station
  end

  def del_station(station)
    if present_station_in_route?(station) && @stations.first != station && @stations.last != station
      @stations.delete(station)
    else
      puts "Невозможно удалить выбранную станцию: #{station.title}"
    end
  end

  def present_station_in_route?(station)
    @stations.include? station
  end
end
