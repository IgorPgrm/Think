#Класс Station (Станция):
#Имеет название, которое указывается при ее создании +
#Может принимать поезда (по одному за раз)
#Может возвращать список всех поездов на станции, находящиеся в текущий момент
#Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
#Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

class Station
  trains = {}
  train_index = 0

  def initialize(title)

  end

  def add_train train #принимает объект поезд
    trins["id#{train_index}"] = { train: train }
  end

  def train departure #отправление поезда

  end

  def show_trains

  end

  def show_trains_by_type #отображение по типу

  end
end