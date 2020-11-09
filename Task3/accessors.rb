module Accessors
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods

  def attr_accessor_with_history(*names)
    names.each do |name|
      method_at = "@#{name}".to_sym
      method_history = "@#{name}_history"
      define_method(name){instance_variable_get(method_at)}
      define_method("#{name}="){|value| instance_variable_set method_at, value}
    end
  end

  end

  module InstanceMethods

  end
end
