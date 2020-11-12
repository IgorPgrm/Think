module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(attr, type, *args)
      @validate ||= []
      @validate << { attr: attr, type: type, args: args }
      puts "Class-validate: #{@validate}"
    end
  end

  module InstanceMethods
    # validate :name, :presence
    # validate :name, :format, /A-Z/
    # validate :name, :type, String

    def valid?
      validate! ? true : false
    end

    private

    def validate!
      self.class.instance_variable_get('@validate').each do |var|
        attr = var[:attr]
        type = var[:type]
        attr_var = instance_variable_get("@#{attr}")
        arg = var[:args][0]
        send type.to_s, attr, attr_var, arg
      end
    end

    def presence(attr, value, _arg)
      raise ArgumentError, "#{attr} is empty or nil!" if value.nil? || value.empty?
    end

    def format(attr, value, regexp)
      raise RegexpError, "Format of #{attr} should be #{regexp}" if value !~ regexp
    end

    def type(attr, value, arg)
      raise ArgumentError, "#{attr} type must be #{arg}!" if value.class != arg
    end

    def length(attr, value, arg)
      raise ArgumentError, "#{attr} not define" if value.nil? || value.empty?

      raise ArgumentError, "#{attr} should be min: or max: value" if arg.nil?

      if !arg[:min].nil?
        min = arg[:min]
        min_t = "min: #{min}"
        value_min = value.length < min
      elsif !arg[:max].nil?
        max = arg[:max]
        max_t = "max: #{max}"
        value_max = value.length > max
      end

      raise ArgumentError, "#{attr} length should be #{min_t} #{max_t} chars" if value_max || value_min
    end
  end
end
