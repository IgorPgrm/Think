module TestModule
  def seed
    trains = %w[SAP-12 LAST0 EXPRS CAR-10 VL0-12 APP-99 CTR-12]
    trains.each_with_index do |train, index|
      index %2 == 0 ? type = :passenger : type = :cargo
      @main_trains << Train.new(train, type)
    end
    @current_train = @main_trains.first

    10.times{@main_carriages << PassengerCarriage.new(54)}
    10.times{@main_carriages << CargoCarriage.new(10_000)}
    rand = Random.new
    @main_carriages.each do |car|
      if car.type == :passenger
        rand.rand(54).times do
          car.add_passenger
        end
      @current_train.add_carriage car
      elsif car.type == :cargo
        car.load rand.rand(10000)
        @main_trains[1].add_carriage car
      else
        raise ArgumentError, "Неверный тип вагона"
      end
    end





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

    @main_carriages.shuffle!.shuffle!
  end
end