# frozen_string_literal: true

require_relative 'module'

class Carriage
  include ModuleManufacturer::InstanceMethods
  attr_reader :type

  def initialize(type)
    @type = type
    validate!
    # register_instance
  end

  def show_info
    if type == :passenger
      print "Всего мест: [#{total_count}] Занято: [#{busy_places}] Свободно: [#{free_places}]"
    else
      print "Всего объёма: [#{total_volume}] Занято: [#{busy_volume}] Свободно: [#{free_volume}]"
    end
  end

  def validate?
    validate!
  rescue StandardError
    false
  end

  protected

  def validate!
    raise ArgumentError, 'Тип вагона указан неверно' unless %i[passenger cargo].include?(type)
  end
end
