module Accessors
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods

  def attr_accessor_with_history(*names)
    names.each do |name|
      method_var = "@#{name}".to_sym
      class_eval %Q{
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
      }
    end
  end

  end

  module InstanceMethods

  end
end
