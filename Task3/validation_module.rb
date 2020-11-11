module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validation(name, type, *args)
      @validate ||= []
      @validate << {name: name, type: type, args: args}
    end
  end

  module InstanceMethods
    #validate :name, :presence
    #validate :name, :format, /A-Z/
    #validate :name, :type, String

    def validate!
      self.class.instance_variable_get(@validate).each do |var|
        name = var[:name]
        type = var[:type]
        arg = var[:args]
        send "#{type}", name, arg
      end
    end

    def valid?; validate! ? true : false; end

    def precence(name, arg)
      
    end

    def format(name,arg)

    end

  end
end

