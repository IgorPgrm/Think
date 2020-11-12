# frozen_string_literal: true

require_relative 'module'
require_relative 'validation_module'

class Carriage
  include ModuleManufacturer::InstanceMethods
  include Validation
  attr_reader :type
  validate :type, :type_of, Symbol
  validate :type, :range, [:cargo, :passenger]

  def initialize(type)
    @type = type
    validate!
    # register_instance
  rescue ArgumentError => e
    puts e.message
  end

  def show_info
    if type == :passenger
      print "Всего мест: [#{total_count}] Занято: [#{busy_places}] Свободно: [#{free_places}]"
    else
      print "Всего объёма: [#{total_volume}] Занято: [#{busy_volume}] Свободно: [#{free_volume}]"
    end
  end
end
