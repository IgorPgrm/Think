# frozen_string_literal: true

require_relative 'module'
require_relative 'validation_module'

class Carriage
  include ModuleManufacturer::InstanceMethods
  include Validation
  attr_reader :type

  def initialize(type)
    @type = type
    # register_instance
  end

  def show_info
    if type == :passenger
      print "Всего мест: [#{total_count}] Занято: [#{busy_places}] Свободно: [#{free_places}]"
    else
      print "Всего объёма: [#{total_volume}] Занято: [#{busy_volume}] Свободно: [#{free_volume}]"
    end
  end
end
