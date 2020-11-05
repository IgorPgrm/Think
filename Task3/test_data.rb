module TestModule
  def seed
    @main_trains << Train.new("SAP-12", :passenger)
    @main_trains << Train.new("LAST0", :passenger)
    @main_trains << Train.new("EXPRS", :passenger)
    @main_trains << Train.new("CAR-10", :cargo)
    @main_trains << Train.new("VLKSM", :cargo)
    @current_train = @main_trains.first
    @main_station << Station.new("Москва")
    @main_station << Station.new("Тула")
    @main_station << Station.new("Новгород")
    @main_station << Station.new("Воронеж")
    route = Route.new(@main_station.first, @main_station.last)
    route2 = Route.new(@main_station.last, @main_station.first)
    @main_station << Station.new("Лиски")
    route.add_station(@main_station.last)
    @main_station << Station.new("Липецк")
    route2.add_station(@main_station.last)
    route.add_station(@main_station.last)
    @main_station << Station.new("Россошь")
    route.add_station(@main_station.last)
    @main_station << Station.new("Каменск-Шахтинский")
    route.add_station(@main_station.last)
    route2.add_station(@main_station.last)
    @main_routes << route
    @main_routes << route2
    @current_route = route2
    @current_station = @main_station.last

    10.times{@main_carriages << PassangerCarriage.new()}
    10.times{@main_carriages << CargoCarriage.new()}
    @current_carriage = @main_carriages.last
    @main_carriages.shuffle!.shuffle!
  end
end