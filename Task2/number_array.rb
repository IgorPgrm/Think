# Заполнить массив числами от 10 до 100 с шагом 5
mass = []
(10..100).each do |numb|
  if (numb % 5 == 0)
    mass << numb
  end
end
puts mass