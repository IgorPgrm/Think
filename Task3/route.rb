#Имеет начальную и конечную станцию, а также список промежуточных станций.
#   Начальная и конечная станции указываютсся при создании маршрута,
#   а промежуточные могут добавляться между ними.
#
#Может добавлять промежуточную станцию в список
#Может удалять промежуточную станцию из списка
#Может выводить список всех станций по-порядку от начальной до конечной

class Route
  attr_reader :first_station, :last_station, :stations

  def initialize (first_station, last_station)
    @first_station, @last_station = first_station, last_station
    @stations = [ @first_station, @last_station]
  end

  def show_route
    @stations
  end

  def add_station station
    @stations.insert(-2,station) unless present_station_in_route? station
  end

  def present_station_in_route? station
    @stations.include? station
  end

end