#Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
#Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

class Station

  def initialize(title)
    @title = title

    @trains = {}
    @train_index = 0
  end

  def add_train train #принимает объект поезд
    puts train.inspect
    @trains["id#{@train_index}".to_sym] = { train: train }
    @train_index += 1
  end

  def train_departure #отправление поезда

  end

  def show_trains
    @trains.each do |key, trains|
      trains.each do |key, value|
        puts "\t\t #{value.number}\t| #{value.type}\t| #{value.carriages}"
      end
    end
  end

  def show_trains_by_type type #отображение по типу
    @trains.each do |key, trains|
      trains.each do |key, value|
        puts "\t\t #{value.number}\t| #{value.type}\t| #{value.carriages}" if value.type == type.to_sym
      end
    end
  end
end