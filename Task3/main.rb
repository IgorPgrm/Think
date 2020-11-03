require_relative 'cargo_train'
require_relative 'cargo_carriage'
require_relative 'passenger_train'
require_relative 'passenger_carriage'
require_relative 'route'
require_relative 'station'
#require_relative 'test_data' #Для загрузки тестовых данных

class Main
  #include TestModule #Для загрузки тестовых данных
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

    #seed #Для загрузки тестовых данных

    show_current_info
    main_menu
  end

  def show_current_info
    print "Выбраны: поезд:["
    print @current_train == @na ? "\u001B[31m#{@na}\u001B[0m" : "\u001B[32m#{@current_train.number}\u001B[0m"
    print"] станция:["
    print @current_station == @na ? "\u001B[31m#{@na}\u001B[0m" : "\u001B[32m#{@current_station.title}\u001B[0m"
    print "] маршрут:["
    print @current_route == @na ? "\u001B[31m#{@na}\u001B[0m" : "\u001B[32m#{@current_route.title}\u001B[0m"
    print "] вагон:["
    print @current_carriage == @na ? "\u001B[31m#{@na}\u001B[0m" : "\u001B[32m#{@current_carriage.type}\u001B[0m"
    print "]\n"
  end

  def choise_station
    puts "\nВыберите станцию:"
    input = gets.chomp.to_i
    @current_station = @main_station[input-1]
    puts "Выбрана станция: #{@current_station.title}"
  end

  def choise_route
    puts "\nВыберите маршрут:"
    input = gets.chomp.to_i
    @current_route = @main_routes[input-1]
    puts "Выбран маршрут: #{@current_route.title}"
  end

  def choise_carriage
    puts "\nВыберите вагон:"
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
      @current_route = @main_routes.last
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
        print "\n#{index} Станция #{station.title}"
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
        puts "Поезда с этим маршрутом:\n"
        @main_trains.each { |train|
          puts "[#{train.number}]" if train.route == route}
      end
    else
      puts "\u001B[31mНет маршрутов для отображения\u001B[0m\n\n"
      false
    end
  end

  def def_current_route
    if @current_route == @na
      show_routes ? choise_route : create_new_route
    else
      @current_route
    end
  end

  def def_current_station
    if @current_station == @na
      show_station ? choise_station : create_new_station
    else
      @current_station
    end
  end

  def def_current_train
    if @current_train == @na
      show_trains ? choise_train : create_new_train
    else
      @current_train
    end
  end

  def def_current_carriage
    if @current_carriage == @na
      show_carriages ? choise_carriage : create_new_carriage
    else
      @current_carriage
    end
  end

  def add_station_to_route
    puts "Добавление станции в маршрут"
    if def_current_station && def_current_route
      @current_route.add_station @current_station
      print "Станция #{@current_station.title} добавлена в маршрут "
      puts "#{@current_route.title}"
      puts "#{@current_route.show_route}"
    end
    show_current_info
    menu_station
  end

  def delete_station_from_route
    show_current_info
    if @current_route == @na
      puts "Выберите маршрут и введите его номер"
      choise_route if show_routes
      delete_station_from_route
    else
      puts "Выбран маршрут: #{@current_route.title}\n"
      @current_route.show_route
      if @current_route.stations.count == 2
        clear
        puts "Невозможно удалить станции из маршрута. В маршруте только 2 станции\n"
        show_current_info
        menu_route
      end
      if @current_station == @na
        clear
        show_current_info
        puts "Станция для удаления не выбрана. Выберите станцию:\n"
        choise_station if show_station
      end
      puts "Выбрана станция для удаления:#{@current_station.title}"
      puts "\u001B[43m\u001B[31mОбратите внимание что нельзя удалять начальную и конечные станции маршрута\u001B[0m"
      puts "Удалить станцию #{@current_station.title}? \n1. Удалить\n2.Выбрать другую"
      input = gets.chomp.to_i
      case input
      when 2
        clear
        show_current_info
        choise_station if show_station
        delete_station_from_route
      end
      clear
      @current_route.del_station(@current_station)
      puts "Удалена станция #{@current_station.title} из маршрута\n\n"
      @current_station = @na
      show_current_info
      menu_station
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
    clear
    show_current_info
    case input
    when 0
      main_menu
    when 1
      choise_station if show_station
      puts "\n"
      menu_station
    when 2
      create_new_station
    when 3
      add_station_to_route
    when 4
      delete_station_from_route
    when 5
      create_new_route
    when 6
    puts "Станции не прикреплённые к маршрутам:\n"
    show_station
    puts "\n\nСтанции в маршрутах"
    show_routes
    menu_station
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
        print "#{index}.\t#{type}\tВагоны: #{train.carriages.count}\tПоезд: #{train.number} \n"
        puts "На станции:#{train.current_station.title}" unless train.current_station.nil?
      end
    end
  end

  def create_new_train
    puts "Создание нового поезда \n\n"
    begin
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
    @main_trains << Train.new(number, type)
    rescue ArgumentError => e
    puts "Ошибка"
    puts e.message
    retry
    end
    @current_train = @main_trains.last
    show_current_info
    puts "Создан поезд #{@current_train.number}\n"
    menu_train
  end

  def delete_train
    if @current_train == @na
      puts "Выберите поезд для удаления"
      choise_train if show_trains
      delete_train
    end
    puts "#{@current_train.number} удалить?"
    puts "1. Удалить этот поезд. 2. Выбрать другой для удаления 0. Отмена"
    input = gets.chomp.to_i
    case input
    when 0
      clear
      show_current_info
      main_menu
    when 2
      clear
      @current_train = @na
      delete_train
    end
    clear
    @main_trains.delete(@current_train)
    puts "Поезд #{@current_train.number} - удалён\n\n"
    @current_train = @na
    show_current_info
    main_menu
  end

  def add_route_to_train
    quest = "Продолжить добавление маршрута к поезду? \n1-Да \n2-Выбрать другой \n0-Отмена\n"
    puts "Добавление маршрута поезду"
    puts "Выбран поезд :#{@current_train.number} Тип: #{@current_train.type}" if def_current_train
    puts quest
    input = gets.chomp.to_i
    case input
    when 2
      clear
      choise_train if show_trains
    when 0
      clear
      show_current_info
      main_menu
    end
    puts "Выберан маршрут: #{@current_route.title}" if def_current_route
    puts quest
    input = gets.chomp.to_i
    case input
    when 2
      clear
      choise_route if show_routes
    when 0
      clear
      show_current_info
      main_menu
    end
    @current_train.add_route @current_route
    puts "Маршрут добавлен к поезду #{@current_train.number}"
    puts "Текущая станция поезда #{@current_station.title}"
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

  def move_train direction
    dir = ""
    if @current_train == @na
      puts "Выберите поезд:\n"
      choise_train if show_trains
      move_train direction
    elsif @current_train.route == nil
      choise_route if show_routes
      @current_train.add_route @current_route
      move_train direction
    else
      clear
      if direction == 1
        @current_train.move_forvard
        dir = "следующую"
      elsif direction == 2
        dir = "предыдущую"
        @current_train.move_back
      end
      puts "Поезд прибыл на #{dir} станцию #{@current_train.current_station.title}"
    end
    show_current_info
    menu_train
  end

  def menu_train
    show_trains
    print "\n"
    puts <<~TRM
      Поезд
      1. Создать поезд
      2. Удалить поезд
      3. Прицепить вагон к поезду
      4. Отцепить вагон от поезда
      5. Добавить маршрут поезду
      6. Удалить маршрут у поезда
      7. Переместить на станцию вперёд
      8. Переместить на станцию назад
      9. Выбрать поезд для добавления вагонов/\станций
      0. Выход в меню
    TRM

    input = gets.chomp.to_i
    clear
    show_current_info
    case input
    when 0
      main_menu
    when 1
      create_new_train
    when 2
      delete_train
    when 3
      add_carriage_to_train
    when 4
      remove_carriage_from_train
    when 5
      add_route_to_train
    when 6
      remove_route_from_train
    when 7
      move_train 1
    when 8
      move_train 2
    when 9
      choise_train if show_trains
      clear
      show_current_info
      menu_train
    end
  end

  def show_carriages
    unless @main_carriages.any?
      puts "Нет вагонов для отображения"
      false
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
      @main_carriages << PassengerCarriage.new
    when 2
      @main_carriages << CargoCarriage.new
    end
    @current_carriage = @main_carriages.last
    clear
    puts "Вагон создан\n"
    show_current_info
    puts "\n"
    show_carriages
    puts "\n"
    menu_carriage
  end

  def delete_carriage
    if @current_carriage == @na
      puts "Вагон не выбран, удалять нечего\n"
      main_menu
    else
      puts "Выбран вагон #{@current_carriage.type}. Удалить? 1- Да 2-Выбрать другой 0-Отмена\n"
      input = gets.chomp.to_i
      clear
      show_current_info
      case input
      when 0
        main_menu
      when 2
        @current_carriage = @na
        delete_carriage
      end
      clear
      @main_carriages.delete(@current_carriage)
      puts "Вагон #{@current_carriage.type} - удалён\n\n"
      @current_train = @na
      show_current_info
      main_menu
    end
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
      6. Выбрать вагон
      0. Главное меню
    CAR

    input = gets.chomp.to_i
    clear
    show_current_info
    case input
    when 0
      clear
      main_menu
    when 1
      show_carriages
      puts "\n"
      menu_carriage
    when 2
      create_new_carriage
    when 3
      delete_carriage
    when 4
      puts "Добавление вагона к поезду"
      add_carriage_to_train
    when 5
      remove_carriage_from_train
    when 6
      choise_carriage if show_carriages
      menu_carriage
    end
  end

  def delete_route
    puts "Выберите маршрут для удаления"
    if @current_route == @na
      choise_route if show_routes
      delete_route
    else
      puts "Выбранный маршрут: #{@current_route.title} . 1-Удалить 2-Выбрать другой 0-Отмена"
      input = gets.chomp.to_i
      case input
      when 0
        clear
        show_current_info
        main_menu
      when 2
        clear
        @current_route = @na
        delete_route
      end
      clear
      @main_routes.delete(@current_route)
      puts "Маршрут #{@current_route.title} - удалён\n\n"
      @current_route = @na
      show_current_info
      main_menu
    end
  end

  def menu_route
    puts <<~RO
      Маршруты
      1. Просмотр маршрутов
      2. Создать маршрут
      3. Удалить маршрут
      4. Добавить станцию в маршрут
      5. Удалить станцию из маршрута
      6. Выбрать маршрут
      0. Выход
    RO
    input = gets.chomp.to_i
    clear
    show_current_info
    case input
    when 0
      main_menu
    when 1
      puts "Просмотр маршрутов"
      show_routes
      puts "\n"
      menu_route
    when 2
      create_new_route
    when 3
      delete_route
    when 4
      add_station_to_route
    when 5
      delete_station_from_route
    when 6
      choise_route if show_routes
      menu_route
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
    clear
    show_current_info
    case  input
    when 1
      show_station
    when 2
      show_trains
    when 3
      show_routes
    when 4
      show_carriages
    end
    show_current_info
    main_menu
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
    clear
    show_current_info
    case @cmd
    when 0
      clear
      exit
    when 1
      menu_station
    when 2
      menu_train
    when 3
      menu_route
    when 4
      menu_carriage
    when 5
      menu_show
    end
  end
end

main = Main.new
