p "Здравствуйте! Вас приветсвует программа рассчёта идеальной массы тела"
p "Введите своё имя:"
name = gets.chomp
p "Спасибо, #{name}!"
p "Теперь введите Ваш рост:"
height = gets.chomp.to_f
ideal_weight = (height.to_f - 110) * 1.15

if ideal_weight < 0
  p "Ваш вес уже оптимальный"
else
  p "Идеальный вес для роста #{height}см, составляет #{ideal_weight} кг"
end
