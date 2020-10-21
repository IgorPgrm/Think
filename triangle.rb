mass = []
p "Введите стороны треугольника. AB="
mass.push gets.chomp.to_f	# 5
p "BC="
mass.push gets.chomp.to_f	#5
p "AC="
mass.push gets.chomp.to_f	#10

gip = mass.max # гипотенуза
cat1, cat2 = mass.min(2)

if (gip == cat1 && gip == cat2)
  p "Равносторонний треугольник1"
else
  if gip**2 == (cat1**2 + cat2**2)
    p "Прямоугольный треугольник"
  else
    if (gip == cat1 || gip == cat2)
      p "Равнобедренный треугольник"
    else
      p "Неверно введены данные"
    end
  end
end
		
