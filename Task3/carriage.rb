require_relative 'module'

class Carriage
  include ModuleManufacturer::InstanceMethods
  attr_reader :type

  def initialize(type)
    @type = type
    validate!
    #register_instance
  end

  def show_info
    if self.type == :passenger
      print "Всего мест: [#{self.total_count}] Занято: [#{self.busy_places}] Свободно: [#{self.free_places}]"
    else
      print "Всего объёма: [#{self.total_volume}] Занято: [#{self.busy_volume}] Свободно: [#{self.free_volume}]"
    end
  end

  def validate?
    validate!
  rescue
    false
  end

  protected
  def validate!
    raise ArgumentError, "Тип вагона указан неверно" unless [:passenger, :cargo].include?(type)
  end
end