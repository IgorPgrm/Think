require_relative 'cargo_train'
require_relative 'cargo_carriage'
require_relative 'passenger_train'
require_relative 'passenger_carriage'
require_relative 'route'
require_relative 'station'

=begin
Добавить текстовый интерфейс:

Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
     - Создавать поезда
     - Назначать маршрут поезду
     - Добавлять вагоны к поезду
     - Отцеплять вагоны от поезда
     - Перемещать поезд по маршруту вперед и назад
     - Просматривать список станций и список поездов на станции
=end

@main_station = []
@main_routes = []
@main_trains = []
@main_carriages = []
@cmd = 0

def choise_two_station
  two_station = [nil, nil]
  loop do
    @main_station.each.with_index(1) { |station, index| puts "#{index} - #{station.title}" }
    if two_station[0].nil?
      puts "Выберите начальную станцию в маршруте из списка и введите её номер или 0 для выхода:"
      input = gets.chomp.to_i
      two_station[0] = @main_station[input-1]
      @main_station.delete_at(input-1)
      clear
    else
      if two_station[1].nil?
        puts "Выберите конечную станцию в маршруте из списка и введите её номер или 0 для выхода:"
        input = gets.chomp.to_i
        two_station[1] = @main_station[input-1]
        @main_station.delete_at(input-1)
        clear
      else
        break
      end
    end
  end
  return two_station
end

def create_new_route
  puts "Создание нового маршрута"
  if @main_station.size < 2
    puts "Для составления маршрута, необходимо 2 станции"
    sleep(2)
    clear
    create_new_station
  else
    clear
    two_station = choise_two_station
    @main_routes << Route.new(two_station.first, two_station.last)
    puts "Был создан маршрут:"
    print "#{@main_routes.last.stations.first.title} -> "
    print "#{@main_routes.last.stations.last.title} \n"
    sleep(2)
    menu_route
  end
end

def create_new_station
  puts <<~EOF
    Создание новой станции
    Введите имя новой станции:
EOF
  name = gets.chomp
  station = Station.new(name)
  @main_station << station
  clear
  puts "Создана станция: #{station.title}"
  sleep(0.5)
  menu_station
end

def show_station
  if @main_station.any?
    @main_station.each.with_index(1) { |station, index| puts "#{index} Станция #{station.title}" }
  else
    puts "\tСтанций нет"
    #menu_station
  end
end

def clear
  system('clear')
end

def show_routes
  if @main_routes.any?
    @main_routes.each.with_index(1) do |route, index|
      print "#{index}.\t"
      puts "#{route.show_route}"
    end
  else
    puts "Нет маршрутов для отображения"
    false #необходимо для проверки
  end
end

def add_station_to_route
  puts "Добавление станции в маршрут"
  puts "Выберите маршрут"
  unless show_routes
    create_new_route
  else
    input = gets.chomp.to_i
    route = @main_routes[input-1]
    clear
    puts "Выберите станцию для добавления в маршрут"
    show_station
    input = gets.chomp.to_i
    route.add_station @main_station[input-1]
    @main_station.delete_at(input-1)
    clear
    "Станция добавлена в маршрут"
    route.show_route
    menu_station
  end
end

def delete_station_from_route
  puts "Выберите маршрут и введите его номер"
  unless show_routes
    create_new_route
  else
    input = gets.chomp.to_i
    route = @main_routes[input-1]
  end
  if route.stations.count == 2
    puts "Невозможно удалить станции из маршрута. В маршруте только 2 станции\n"
    menu_route
  else
    puts "Обратите внимание что нельзя удалять начальную и конечные станции маршрута"
    puts "Выберите станцию для удаления:"
    route.show_route
    input = gets.chomp.to_i
    station = route.stations[input-1]
    print "Выбранная станция: #{station.title}"
    route.del_station station
    puts " удалена"
    sleep(2)
    main_menu
  end
end

def menu_station
  puts <<~ST
    Станции
    1. Просмотр станций
    2. Создать станцию
    3. Добавить к маршруту
    4. Удалить станцию из маршрута

    0. Главное меню
ST
  input = gets.chomp.to_i
  case input
  when 0
    clear
    main_menu
  when 1
    clear
    puts "Станции не прикреплённые к маршрутам:\n"
    show_station
    if  @main_routes.any?
    puts "\nСтанции в маршрутах"
    show_routes
    end
    puts "\n"
    menu_station
  when 2
    clear
    create_new_station
  when 3
    clear
    add_station_to_route
  when 4
    clear
    delete_station_from_route
  end
end

def show_trains
  unless @main_trains.any?
    puts "Нет поездов для отображения\n\n"
    main_menu
    false
  else
    puts "Список поездов:"
    @main_trains.each.with_index(1) do |train, index|
      type = "Пассажирский" if train.type == :passenger
      type = "Грузовой" if train.type == :cargo
      puts "\t#{index}.\t#{type}\t\tПоезд: #{train.number}"
    end
  end
end

def create_new_train
  puts "Создание нового поезда \n\n"
  puts "Введите номер поезда:"
  number = gets.chomp.to_s
  clear
  puts "Поезд \"#{number}\"\n\n"
  puts "Введите тип поезда. \n1. Пассажирский \n2. Грузовой\n"
  input = gets.chomp.to_i
  case input
  when 1
    type = :passenger
  when 2
    type = :cargo
  end
  @main_trains << Train.new(number, type)
  puts "\nПоезд добавлен\n"
  show_trains
  puts "\n"
  menu_train
end

def delete_train
  unless show_trains
    puts "Поездов нет, удалять нечего"
  else
    puts "Выберите поезд для удаления"
    input = gets.chomp.to_i
    puts "Выбран: #{input}"
    puts "Поезд #{@main_trains[input-1].number} - удалён"
    @main_trains.delete_at(input-1)
  end
  menu_train
end

def menu_train
  puts <<~TRM
  Поезд
  1. Просмотр поездов
  2. Создать поезд
  3. Удалить поезд
  4. Прицепить вагон к поезду
  5. Отцепить вагон от поезда
  6. Добавить маршрут поезду
  7. Удалить маршрут у поезда
  0. Выход в меню
  TRM

  input = gets.chomp.to_i
  case input
  when 0
    clear main_menu
  when 1
    clear
    show_trains
    puts "\n\n"
    menu_train
  when 2
    clear
    create_new_train
  when 3
    clear
    delete_train
  end
end

def menu_carriage
  # code here
end

def delete_route
  puts "Выберите маршрут для удаления"
  unless show_routes
    create_new_route
  else
  input = gets.chomp.to_i
  end
  puts "Выбран маршрут для удаления: #{@main_routes[input-1].stations.first.title} -
        #{@main_routes[input-1].stations.last.title}"
  @main_routes.delete_at(input-1)
  puts "Маршрут удалён"
  show_routes
  puts "\n"
  menu_route
end

def menu_route
  puts <<~RO
    Маршруты
    1. Просмотр маршрутов
    2. Создать маршрут
    3. Удалить маршрут
    4. Добавить станцию в маршрут
    5. Удалить станцию из маршрута
    0. Выход
  RO
  input = gets.chomp.to_i
  case input
  when 0
    clear
    main_menu
  when 1
    clear
    puts "Просмотр маршрутов"
    show_routes
    puts "\n"
    menu_route
  when 2
    clear
    create_new_route
  when 3
    clear
    delete_route
  when 4
    clear
    clear add_station_to_route
  when 5
    clear
    delete_station_from_route
  end
end

def menu_show
  # code here
end

def main_menu
  loop do
    puts "Выберите пункт меню: "
    puts <<~MME
      1. Станции \t[просмотр] | [создать] [добавить] [удалить]
      2. Поезд \t[просмотр] | [создать] [добавить] [удалить] | [Переместить вперёд] [Переместить назад]
      3. Маршрут \t[просмотр] | [создать] [удалить] | [добавить станцию] [удалить станцию]
      4. Вагоны \t[просмотр] | [создать] [удалить] | [прицепить] [отцепить]
      5. Просмотр

      0. Выход из программы
    MME

    @cmd = gets.chomp.to_i

    case @cmd
    when 0
      clear
      exit
    when 1
      clear
      menu_station
    when 2
      clear
      menu_train
    when 3
      clear
      menu_route
    when 4
      clear
      menu_carriage
    when 5
      clear
      menu_show
    end
    break
  end
end

main_menu
