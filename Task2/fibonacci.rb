# Заполнить массив числами фибоначчи до 100
mass = []
counter = 0

def fibonacci numb
  return numb if numb < 2
  fibonacci(numb-2) + fibonacci(numb-1)
end

loop do
  numb = fibonacci counter
  break if numb >= 100
  mass << numb
  counter += 1
end

puts mass.inspect

