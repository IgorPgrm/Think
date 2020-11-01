module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances

    def instances
      @instances
    end

    def instances_plus
      @instances ||= 0
      @instances += 1
    end
  end

  module InstanceMethods
    @instances = 0
    protected
    def register_instance
      self.class.instances_plus
    end
  end
end