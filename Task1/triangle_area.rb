p "Введите длину основания треугольника в см"
osn = gets.chomp.to_f
p "Введите высоту треугольника в см"
height = gets.chomp.to_f
area = 0.5 * (osn * height)

p "Площадь с основанием #{osn} и высотой #{height} равна #{area}см²"
