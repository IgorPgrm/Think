require_relative 'cargo_train'
require_relative 'cargo_carriage'
require_relative 'passenger_train'
require_relative 'passenger_carriage'
require_relative 'route'
require_relative 'station'

=begin
    К пассажирскому поезду можно прицепить только пассажирские, к грузовому - грузовые.
    При добавлении вагона к поезду, объект вагона должен передаваться как аргумент метода
и сохраняться во внутреннем массиве поезда, в отличие от предыдущего задания, где мы считали
только кол-во вагонов. Параметр конструктора "кол-во вагонов" при этом можно удалить.
Добавить текстовый интерфейс:

Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
     - Создавать станции
     - Создавать поезда
     - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
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
      main_menu if input == 0
      two_station[0] = @main_station[input-1]

      clear
    else
      if two_station[1].nil?
        puts "Выберите конечную станцию в маршруте из списка и введите её номер или 0 для выхода:"
        input = gets.chomp.to_i
        main_menu if input == 0
        two_station[1] = @main_station[input-1]
        clear
      else
        @main_station.delete(two_station[0])
        @main_station.delete(two_station[1])
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
    print "#{@main_routes.last.first_station.title} -> "
    print "#{@main_routes.last.last_station.title}"
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
  puts <<~EOF
    \n1. Создать станцию
    2. Просмотр станций
    3. Добавление станции в маршрут
    4. Удалить станцию
    5. Создать маршрута
    0. Выход в главное меню
EOF
  input = gets.chomp.to_i
  case input
  when 1
    clear
    create_new_station
  when 2
    clear
    show_station
  when 3
    clear
    add_station_to_route
  when 4
    clear
    delete_station
  when 5
    clear
    create_new_route
  when 0
    clear
    main_menu
  end
end

def show_station
  if @main_station.any?
    @main_station.each.with_index(1) { |station, index| puts "#{index} Станция #{station.title}" }
  else
    puts "\tСтанций без маршрутов нет"
    menu_station
  end
end

def clear
  system('clear')
end

def show_routes
  @main_routes.each.with_index(1) do |route, index|
    print "#{index}.\t"
    puts "#{route.show_route}"
  end
end

def add_station_to_route
  unless @main_routes.any?
    create_new_route
  else
  puts "Добавление станции в маршрут"
  puts "Выберете маршрут"
  show_routes
  end
  input = gets.chomp.to_i
  route = @main_routes[input-1]
  clear
  puts "Выберете станцию для добавления в маршрут"
  show_station
  input = gets.chomp.to_i
  route.add_station @main_station[input-1]
  @main_station.delete_at(input-1)
  clear
  "Станция добавлена в маршрут"
  route.show_route
  menu_station
end

def menu_station
  puts <<~ST
    Станции
    1. Просмотр станций
    2. Создать станцию
    3. Добавить к маршруту
    4. Удалить

    0. Главное меню
ST
  input = gets.chomp.to_i
  case input
  when 0
    clear
    main_menu
  when 1
    clear
    puts "Просмотр станций:\n"
    show_station
    menu_station
  when 2
    clear
    create_new_station
  when 3
    clear
    add_station_to_route
  when 4
    clear
    delete_station
  end
end

def menu_train
  # code here
end

def menu_carriage
  # code here
end

def menu_route
  clear
  puts <<~RO
    Маршруты
    1. Просмотр маршрутов
    2. Создать маршрут
    3. Удалить маршрут
    4. Добавить станцию в маршрут
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
    "Любая клавиша чтобы продолжить"
    gets.chomp.to_i
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
  end
end

def menu_show
  # code here
end

def main_menu
loop do
  puts "Выберете пункт меню: "
  puts <<~MME
    1. Станции \t[просмотр] | [создать] [добавить] [удалить]
    2. Поезд \t[просмотр] | [создать] [добавить] [удалить] | [Переместить вперёд] [Переместить назад]
    3. Маршрут \t[просмотр] | [создать] [удалить] | [добавить станцию] [удалить станцию]
    4. Вагоны \t[просмотр] | [создать] [удалить] | [прицепить] [отцепить]
    5. Просмотр
  MME


  @cmd = gets.chomp.to_i

  case @cmd
  when 0
    break
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
  #system('clear')
  end
end

clear
main_menu
