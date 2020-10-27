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
      puts "Выберите первую станцию в маршруте из списка и введите её номер:"
      input = gets.chomp.to_i
      two_station[0] = @main_station[input-1]
    else
      if two_station[1].nil?
        puts "Выберите вторую станцию в маршруте из списка и введите её номер:"
        input = gets.chomp.to_i
        two_station[1] = @main_station[input-1]
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
  16.times{ print '='}
  puts <<~EOF
    \n1. Создать станцию
    2. Просмотр станций
    3. Перейти к созданию маршрута
    4. Удаление станции
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
    create_new_route
  when 4
    clear
    delete_station
  when 0
    clear
    main_menu
  end
end

def show_station
  puts "Просмотр станций:\n"
  if @main_station.any?
    @main_station.each { |station| puts "\tСтанция #{station.title}" }
  else
    puts "\tПусто"
  end
  puts "\n\n1. Создать\n0. Выйти"
  input = gets.chomp.to_i
  case input
  when 1
    clear
    create_new_station
  when 0
    clear
  end
end

def clear
  system('clear')
end

def menu_station
  clear
  puts <<~ST
    Станции
    1. Просмотр
    2. Создать
    3. Добавить
    4. Удалить
ST
  input = gets.chomp.to_i
  case input
  when 1
    clear
    show_station
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

def main_menu
loop do
  puts "Выберете пункт меню: "
  puts <<~EOF
    1. Станции \t[просмотр] | [создать] [добавить] [удалить]
    2. Поезд \t[просмотр] | [создать] [добавить] [удалить] | [Переместить вперёд] [Переместить назад]
    3. Маршрут \t[просмотр] | [создать] [добавить] [удалить] | [добавить станцию] [удалить станцию]
    4. Вагоны \t[просмотр] | [создать] [удалить] | [прицепить] [отцепить]
    5. Просмотр
  EOF


  @cmd = gets.chomp.to_i

  def menu_train
    # code here
  end

  def menu_carriage
    # code here
  end

  def menu_route
    # code here
  end

  def menu_show
    # code here
  end

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
    menu_show
  end
  #system('clear')
  end
end

main_menu
