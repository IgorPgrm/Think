# Заполнить массив числами фибоначчи до 100
mass = []

def fibonacci numb
  return numb if numb < 2
  fibonacci(numb-2) + fibonacci(numb-1)
end

(0..100).each do |n|
  mass << fibonacci(n)
end

puts mass

