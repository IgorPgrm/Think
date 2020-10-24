#Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад,
# но только на 1 станцию за раз.
#Возвращать предыдущую станцию, текущую, следующую, на основе маршрута

class Train
	attr_reader :number, :type, :carriages, :current_station, :next_station, :prev_station
	attr_accessor :route

	def initialize number, type, carriages = 1
		@number = number
		@type = type
		@carriages = carriages
		@speed = 0
		@current_station = ""
		@route = ""
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

	def add_route= route
		@route = route
		@current_station = route.first_station
	end

end