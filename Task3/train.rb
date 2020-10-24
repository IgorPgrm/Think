#Может принимать маршрут следования (объект класса Route).
#При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
#Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
#Возвращать предыдущую станцию, текущую, следующую, на основе маршрута

class Train
	attr_reader :number, :type, :carriages

	def initialize number, type, carriages = 1
		@number = number
		@type = type
		@carriages = carriages
		@speed = 0
	end

	def current_speed
		@speed
	end

	def speed_up
		@speed += 1
	end

	def speed_down
		@speed.positive? ? @speed -= 1 : @speed = 0
	end

	def stop
		@speed = 0
	end

	def add_carriage(count = 1)
		@carriages += count if @speed.zero?
	end

	def remove_carriage(count = 1)
		@carriages -= count if @speed.zero?
	end

end