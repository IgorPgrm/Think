
day_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

def intercalary_year? year
  return 0 if year <= 0
  year % 4 == 0 && year % 100 != 0 || year % 400 == 0
end

puts "Введите год"
year = gets.chomp.to_i
puts "Введите месяц"
month = gets.chomp.to_i
puts "Введите число"
day = gets.chomp.to_i

puts "#{year} #{month} #{day}"

day_index = 0

if month != 1
  day_month[1] = 29 if intercalary_year? year
  day_month.take(month-1).each { |d| day_index += d }
  day_index += day
else
  day_index = day
end

puts "Всего в результате #{day_index} дней"





