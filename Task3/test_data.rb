module TestModule
  def create_test_trains
    trains = %w[SAP-12 LAST0 EXPRS CAR-10 VL0-12 APP-99 CTR-12]
    trains.each_with_index do |train, index|
      type = index.even? ? :passenger : :cargo
      @main_trains << Train.new(train, type)
    end
  end

  def create_test_carriages
    10.times { @main_carriages << PassengerCarriage.new(54) }
    10.times { @main_carriages << CargoCarriage.new(10_000) }
    rand = Random.new
    @main_carriages.each do |car|
      if car.type == :passenger
        rand.rand(54).times do
          car.add_passenger
        end
        @current_train.add_carriage car
      else car.type == :cargo
        car.load rand.rand(10_000)
        @main_trains[1].add_carriage car
      end
    end
  end

  def create_test_stations
    names = %w[Москва Тула Новгород Воронеж Лиски Липецк Россошь Миллерово Каменск Ростов]
    names.each do |nm|
      @main_station << Station.new(nm)
    end
  end

  def create_test_route
    route = Route.new(@main_station.first, @main_station.last)
    route2 = Route.new(@main_station.last, @main_station.first)
    @main_station.each do |st|
      if st != route.stations.last && st != route.stations.first
      route.add_station st unless st == @main_station.last
      end
    end

    @main_station.reverse_each do |st|
      if st != route.stations.last && st != route.stations.first
      route2.add_station st
      end
    end
    @main_routes << route
    @main_routes << route2
    @current_route = route2
  end

  def seed
    create_test_trains
    @current_train = @main_trains.first
    create_test_carriages
    create_test_stations
    create_test_route
    @current_station = @main_station.last

    @main_carriages.shuffle!.shuffle!
  end
end
