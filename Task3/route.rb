class Route
  attr_reader :stations, :title

  def initialize (first_station, last_station)
    @first_station, @last_station = first_station, last_station
    @title = first_station.title.to_s + " -> " + last_station.title.to_s
    @stations = [ @first_station, @last_station]
  end

  def show_route
    @stations.each.with_index(1) do | station, index |
      unless @stations.last == station
        print "#{index}) #{station.title} -> "
      else
        puts "#{index}) #{station.title}"
      end
    end
    return "\n"
  end

  def add_station station
    @stations.insert(-2,station) unless present_station_in_route? station
  end

  def del_station station
    if present_station_in_route?(station) && @stations.first != station && @stations.last != station
      @stations.delete(station)
    else
      puts "Невозможно удалить выбранную станцию: #{station.title}"
    end
  end

  def present_station_in_route? station
    @stations.include? station
  end

end