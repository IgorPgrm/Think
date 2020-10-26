class Station

  def initialize(title)
    @title = title
    @trains = []
  end

  def add_train train
    @trains << train
  end

  def remove_train train
    @trains.delete(train)
  end

  def show_trains
    @trains.each { |train| puts "\t\t #{train.number}\t| #{train.type}\t| #{train.carriages}" }
  end

  def show_trains_by_type type #отображение по типу
    @trains.each { |train| puts "\t\t #{train.number}\t| #{train.type}\t| #{train.carriages}"  if train.type == type}
  end
end