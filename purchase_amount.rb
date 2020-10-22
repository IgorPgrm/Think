title = "Введите название товара или команду \"q\" чтобы выйти"
puts title

tovars = {}
total_cost = 0
total_sum = 0

while true do
  cmd = gets.chomp
  if cmd.downcase == "q"
    break
  else
    puts "Товар: #{cmd}"
    puts "Введите стоимость товара:"
    cost = gets.chomp.to_f
    puts "Введите количество товара:"
    count = gets.chomp.to_f
    tovars[cmd.to_sym] = {cost => count}
    puts "Товар добавлен! Добавить ещё один? Введите название или q чтобы посчитать сумму"
  end
end
puts "Подсчёт товаров:"
tovars.each do |title, cost_and_count|
  cost_and_count.each do |cost, count|
    total_cost = cost * count
    puts "#{title} | #{cost} * #{count} = #{total_cost}"
  end
  total_sum += total_cost
end
puts "__________"
puts "Всего товара по списку на #{total_sum}"
