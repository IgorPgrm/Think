title = "Введите название товара или команду \"q\" чтобы выйти"
puts title

tovars = {}
total_cost = 0
total_sum = 0
counter = 0

loop do
  cmd = gets.chomp
  break if cmd.downcase == "q"
  puts "Товар: #{cmd}"
  puts "Введите стоимость товара:"
  cost = gets.chomp.to_f
  puts "Введите количество товара:"
  count = gets.chomp.to_f
  tovars["id_#{counter}".to_sym] = {title: cmd, price: cost, quantity: count }
  counter += 1
  puts "Товар добавлен! Добавить ещё один? Введите название или q чтобы посчитать сумму"
end
puts "Подсчёт товаров:"
tovars.each do |id, cost_and_count|
  cost_and_count.each do |id|
    total_cost = cost_and_count[:price] * cost_and_count[:quantity]
  end
  puts "#{cost_and_count[:title]} | #{cost_and_count[:quantity]} * #{cost_and_count[:price]} = #{total_cost}"
  total_sum += total_cost
end
puts "__________"
puts "Всего товара по списку на #{total_sum}"
