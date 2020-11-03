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
    puts "class #{self.class}"
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