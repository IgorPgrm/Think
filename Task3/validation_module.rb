module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(attr, type, *args)
      @validate ||= []
      @validate << { attr: attr, type: type, args: args }
    end
  end

  module InstanceMethods
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
    rescue StandardError
      false
    end

    def range(attr, value, range)
      raise ArgumentError, "#{attr} out of range" unless range.include?(value)
    end

    def presence(attr, value, _arg)
      raise ArgumentError, "#{attr} is empty or nil!" if value.nil? || value.empty?
    end

    def format(attr, value, regexp)
      raise RegexpError, "Format of #{attr} should be #{regexp}" if value !~ regexp
    end

    def type_of(attr, value, arg)
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

    def positive(attr, value, _)
      raise ArgumentError, "#{attr} should be Integer positive" if value.nil?
      raise ArgumentError, "#{attr} must be positive!" unless value.positive?
    end
  end
end
