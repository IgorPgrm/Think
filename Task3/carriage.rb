class Carriage
  attr_reader :type

  def initialize(type)
    @type = type
  end

  def show_info
    puts "class #{self.class}"
  end
end