module Accessors
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        raise TypeError.new('Method name is not symbol.') unless name.is_a?(Symbol)
        class_eval <<-CEV, __FILE__, __LINE__ + 1
      def #{name}
        @#{name} || nil
      end

      def #{name}=(value)
        @#{name} = value
      end

      def #{name}_history
        @#{name}_history || [nil] # give default value if not assigned
      end

      def #{name}=(new_value)
        @#{name}_history ||= [nil] # shortcut, compare to your line
        @#{name}_history << @#{name} = new_value
      end
        CEV
      end
    end

    def strong_attr_accessor(method, _class)
      raise TypeError.new('Method name is not symbol!') unless method.is_a?(Symbol)
      define_method(method){ instance_variable_get("@#{method}") }
      define_method("#{method}=") do |val|
        raise TypeError "Value type is not #{_class}." unless val.is_a? _class
        instance_variable_set("@#{method}", val)
      end
    end
  end

  module InstanceMethods
  end
end
