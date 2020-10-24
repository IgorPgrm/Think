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

	def add_route route
		@route = route
		@current_station = route.first_station
	end

	def current_station
		@current_station
	end

	def next_station
		@route.stations[@route.stations.index(@current_station) + 1] unless is_last_station?
	end

	def prev_station
		@route.stations[@route.stations.index(@current_station) - 1] unless is_first_station?
	end

	def is_last_station?
		@current_station == @route.stations.last
	end

	def is_first_station?
		@current_station == @route.stations.first
	end

	def move_forvard
		unless is_last_station?
			@current_station = next_station
			next_station
			@current_station #для возврата методом этой переменной
		end
	end

	def move_back
		unless is_first_station?
			@current_station = prev_station
			prev_station
			@current_station #для возврата методом этой переменной
		end
	end

end