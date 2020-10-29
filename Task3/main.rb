require_relative 'cargo_train'
require_relative 'cargo_carriage'
require_relative 'passenger_train'
require_relative 'passenger_carriage'
require_relative 'route'
require_relative 'station'
require_relative 'test_data' #Для загрузки тестовых данных

=begin
     - Просматривать список станций и список поездов на станции
=end
class Main
  include TestModule #Для загрузки тестовых данных
  def initialize
    @main_station = []
    @main_routes = []
    @main_trains = []
    @main_carriages = []
    @cmd = 0
    @na = "N/a".to_sym
    @current_train = @na
    @current_route = @na
    @current_station = @na
    @current_carriage = @na

    seed #Для загрузки тестовых данных

    show_current_info
    main_menu
  end

  def show_current_info
    print "Выбраны: поезд:["
    print @current_train == @na ? "#{@na}" : "#{@current_train.number}"
    print"] станция:["
    print @current_station == @na ? "#{@na}" : "#{@current_station.title}"
    print "] маршрут:["
    print @current_route == @na ? "#{@na}" : "#{@current_route.stations.first.title} - #{@current_route.stations.last.title}"
    print "] вагон:["
    print @current_carriage == @na ? "#{@na}" : "#{@current_carriage.type}"
    print "] \n"
  end

  def choise_station
    puts "Выберите станцию:"
    input = gets.chomp.to_i
    @current_station = @main_station[input-1]
    puts "Выбрана станция: #{@current_station}"
  end

  def choise_route
    puts "Выберите маршрут:"
    input = gets.chomp.to_i
    @current_route = @main_routes[input-1]
    puts "Выбран маршрут: #{@current_route}"
  end

  def choise_carriage
    puts "Выберите вагон:"
    input = gets.chomp.to_i
    @current_carriage = @main_carriages[input-1]
    puts "Выбран вагон: #{@current_carriage}"
  end

  def choise_train
    puts "Выберите поезд:"
    input = gets.chomp.to_i
    @current_train = @main_trains[input-1]
    puts "Выбран поезд: #{@current_train.number}"
  end


  def choise_two_station
    two_station = [nil, nil]
    loop do
      @main_station.each.with_index(1) { |station, index| puts "#{index} - #{station.title}" }
      if two_station[0].nil?
        puts "Выберите начальную станцию в маршруте из списка и введите её номер или 0 для выхода:"
        input = gets.chomp.to_i
        two_station[0] = @main_station[input-1]
        #@main_station.delete_at(input-1) #не удалять
        clear
      else
        if two_station[1].nil?
          puts "Выберите конечную станцию в маршруте из списка и введите её номер или 0 для выхода:"
          input = gets.chomp.to_i
          two_station[1] = @main_station[input-1]
          #@main_station.delete_at(input-1) #не удалять
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
      create_new_station
    else
      two_station = choise_two_station
      @main_routes << Route.new(two_station.first, two_station.last)
      clear
      puts "Был создан маршрут:"
      print "#{@main_routes.last.stations.first.title} -> "
      print "#{@main_routes.last.stations.last.title} \n"
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
    @current_station = @main_station.last
    show_current_info
    menu_station
  end

  def show_station
    if @main_station.any?
      @main_station.each.with_index(1) do |station, index|
        print "#{index} Станция #{station.title}"
        if station.trains.count > 0
          print " На станции поезда: "
          station.trains.each do |train|
            print "#{train.number}; "
          end
          print "\n"
        end
      end
    else
      puts "\tСтанций нет"
      false
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
      puts "\u001B[31mНет маршрутов для отображения\u001B[0m\n\n"
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
      unless show_station
        puts "нет станций"
        main_menu
      else
        input = gets.chomp.to_i
        route.add_station @main_station[input-1]
        #@main_station.delete_at(input-1) #не удалять станцию
        clear
        "Станция добавлена в маршрут"
        route.show_route
        menu_station
      end
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
      1. Выбрать станцию
      2. Создать станцию
      3. Добавить к существующему маршруту
      4. Удалить станцию из существующего маршрута
      5. Создать новый маршрут
      6. Показать станции
  
      0. Главное меню
  ST
    input = gets.chomp.to_i
    case input
    when 0
      clear
      main_menu
    when 1
      clear
      choise_station
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
    when 5
      clear
      create_new_route
    when 6
    clear
    puts "Станции не прикреплённые к маршрутам:\n"
    show_station
    puts "\n\nСтанции в маршрутах"
    show_routes
    end
  end

  def show_trains
    unless @main_trains.any?
      puts "\u001B[31mНет поездов для отображения\u001B[0m\n"
      false
    else
      puts "Список поездов:"
      @main_trains.each.with_index(1) do |train, index|
        type = "Пассажирский" if train.type == :passenger
        type = "Грузовой" if train.type == :cargo
        print "#{index}.\t#{type}\tВагоны: #{train.carriages.count}\tПоезд: #{train.number} "
        puts "На станции:#{train.current_station.title}" unless train.current_station.nil?
        puts
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
    clear
    @current_train = Train.new(number, type)
    @main_trains << @current_train
    show_current_info
    puts "\nПоезд создан\n"
    show_trains
    puts "\n"
    menu_train
  end

  def delete_train
    if @current_train == @na
      puts "Выберите поезд для удаления"
      choise_train if show_trains
    else
      puts "Выбран: #{@current_train.number}"
      puts "1. Удалить этот поезд. 2. Выбрать другой для удаления"
      input = gets.chomp.to_i
      case input
      when 2
        clear
        choise_train if show_trains
      end
      @main_trains.delete(@current_train)
      puts "Поезд #{@current_train.number} - удалён\n\n"
      @current_train = @na
    end
    show_current_info
    main_menu
  end

  def add_route_to_train
    puts "Добавление маршрута поезду"
    if @current_train == @na
      menu_train unless show_trains
      choise_train if show_trains
    else
      puts "Выбран поезд :#{@current_train.number} Тип: #{@current_train.type}"
    end
    puts "Выберите маршрут"
    if @current_route == @na
    choise_route if show_routes
    else
      puts "Выбран маршрут: #{@current_route.stations.first.title} - #{@current_route.stations.last.title}"
    end
    @current_train.add_route @current_route
    puts "Маршрут добавлен к поезду #{@current_train.number}"
    puts "Текущая станция поезда #{@current_train.current_station.title}"
    @current_route, @current_train = @na
    show_current_info
    menu_route
  end

  def remove_route_from_train
    if @current_train == @na
      choise_train if show_trains
    else
      puts "Маршрут для поезда #{@current_train.number} удален"
      @current_train.remove_route
    end
  end

  def move_train_forward
    puts "Выберите поезд"
    unless show_trains
      puts "Нет поездов для передвижения"
    else
      input = gets.chomp.to_i
      train = @main_trains[input-1]
      train.move_forvard
      puts "Поезд прибыл на следующую станцию #{train.current_station.title}"
      menu_train
    end
  end

  def move_train_back
    puts "Выберите поезд"
    unless show_trains
      puts "Нет поездов для передвижения"
    else
      input = gets.chomp.to_i
      train = @main_trains[input-1]
      train.move_back
      puts "Поезд прибыл на предыдущую станцию #{train.current_station.title}"
      menu_train
    end
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
      8. Переместить на станцию вперёд
      9. Переместить на станцию назад
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
    when 4
      clear
      add_carriage_to_train
    when 5
      clear
      remove_carriage_from_train
    when 6
      clear
      add_route_to_train
    when 7
      clear
      remove_route_from_train
    when 8
      clear
      move_train_forward
    when 9
      clear
      move_train_back
    end
  end

  def show_carriages
    unless @main_carriages.any?
      puts "Нет вагонов для отображения"
    else
      puts "Список вагонов:"
      @main_carriages.each.with_index(1) do |carriage, index|
        type = "Пассажирский" if carriage.type == :passenger
        type = "Грузовой" if carriage.type == :cargo
        puts "\t#{index}.\t#{type}\t\tВагон: #{carriage}"
      end
    end
  end

  def create_new_carriage
    puts "Создание нового вагона \n\n"
    puts "Введите тип вагона. \n1. Пассажирский \n2. Грузовой\n"
    input = gets.chomp.to_i
    case input
    when 1
      @main_carriages << PassangerCarriage.new
    when 2
      @main_carriages << CargoCarriage.new
    end
    puts "\nВагон создан\n"
    show_carriages
    puts "\n"
    menu_carriage
  end

  def delete_carriage
    unless show_carriages
      puts "Вагонов нет, удалять нечего"
    else
      puts "Выберите вагон для удаления"
      input = gets.chomp.to_i
      puts "Выбран: #{input}"
      puts "Вагон #{@main_carriages[input-1]} - удалён"
      @main_carriages.delete_at(input-1)
    end
    menu_carriage
  end

  def add_carriage_to_train
    puts "Выберите поезд из списка"
    unless show_trains
      puts "Для добавления вагонов к поезду, нужно создать поезд"
      menu_train
    else
      input = gets.chomp.to_i
      train = @main_trains[input-1]
      puts "Выбран #{train.number}, кол-во вагонов: #{train.carriages.count}"
      puts "Выберите вагон из списка:"
      unless show_carriages
        puts "Нет вагонов для добавления"
        menu_carriage
      else
        input = gets.chomp.to_i
        carriage = @main_carriages[input-1]
        clear
        if carriage.type == train.type
          train.add_carriage carriage
          puts "Вагон добавлен к поезду #{train.number}"
          @main_carriages.delete(carriage)
          show_trains
          menu_carriage
        else
          puts "Ошибка добавления! Тип вагона не совпадает с типом поезда!"
          main_menu
        end
      end
    end
  end

  def remove_carriage_from_train
    puts "Выберите поезд"
    show_trains
    input = gets.chomp.to_i
    train = @main_trains[input-1]
    if train.carriages.count > 0
      train.carriages.each.with_index(1) do |car, index|
        puts "#{index}. #{car}"
      end
      puts "Выберите вагон для удаления:"
      input = gets.chomp.to_i
      train.carriages.delete_at(input-1)
      clear
      puts "Вагон удалён"
      menu_carriage
    else
      puts "У выбранного поезда #{train.carriages.count} вагонов!"
    end
  end

  def menu_carriage
    puts <<~CAR
      Вагоны
      1. Просмотр вагонов
      2. Создать вагон
      3. Удалить вагон
      4. Добавить вагон к поезду
      5. Удалить вагон из поезда
      0. Главное меню
    CAR

    input = gets.chomp.to_i
    case input
    when 0
      clear
      main_menu
    when 1
      clear
      show_carriages
      puts "\n"
      menu_carriage
    when 2
      clear
      create_new_carriage
    when 3
      clear
      delete_carriage
    when 4
      clear
      puts "Добавление вагона к поезду"
      add_carriage_to_train
    when 5
      clear
      remove_carriage_from_train
    end
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
      puts "Выберите пункт меню: "
      puts <<~MSH
        1. Просмотр станций
        2. Просмотр поездов
        3. Просмотр маршрутов
        4. Просмотр вагонов
  
        0. Выход из программы
      MSH

      input = gets.chomp.to_i
      case  input
      when 1
        clear
        show_current_info
        show_station
      when 2
        clear
        show_current_info
        show_trains
      when 3
        clear
        show_current_info
        show_routes
      when 4
        clear
        show_current_info
        show_carriages
      end
  end

  def main_menu
      puts "Выберите пункт меню: "
      puts <<~MME
        1. Станции \t[просмотр] | [создать] [добавить] [удалить]
        2. Поезд \t[просмотр] | [создать] [удалить] | [Переместить вперёд] [Переместить назад]
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
        show_current_info
        menu_station
      when 2
        clear
        show_current_info
        menu_train
      when 3
        clear
        show_current_info
        menu_route
      when 4
        clear
        show_current_info
        menu_carriage
      when 5
        clear
        show_current_info
        menu_show
      end
  end
end

main = Main.new
