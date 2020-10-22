#Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
# Найти порядковый номер даты, начиная отсчет с начала года учитывая високосный год
#
# Год високосный, если он делится на четыре без остатка, но если он делится на 100 без
# остатка, это не високосный год. Однако, если он делится без остатка на 400,
# это високосный год. Таким образом, 2000 г. является особым високосным годом,
# который бывает лишь раз в 400 лет.

day_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

def intercalary_year? year
  return 0 if year <= 0
  return true if year == 2000
  if year % 4 == 0
    if year % 100 != 0
      if year % 400 != 0
        return true
      end
    end
  else
    return false
  end
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
  if intercalary_year?(year)
    day_month[1] = 29 # февраль 29 дней
  end
  (0..month-2).each do |num|
    day_index += day_month[num]
  end
  day_index += day
else
  day_index = day
end

puts "Всего в результате #{day_index} дней"





