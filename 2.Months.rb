months = { January: 31, February: 28, march: 31, april: 30, 
	may: 31, june: 30, july:31, august: 31, september: 30, 
	october: 31, november: 30, december: 31 }

only_thirty = months.select {|key, val| val == 30}
puts only_thirty

only_thirty.each do |key, value|
	puts "In #{key}: #{value}days"
end

