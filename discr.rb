p "Введите a="
a = gets.chomp.to_i
p "Введите b="
b = gets.chomp.to_i
p "Введите c="
c = gets.chomp.to_i

discr = b**2 - 4*a*c
p "Дискриминант = #{discr}"

if discr <0
	p "Дискриминант меньше нуля. Корней нет"
elsif discr==0
	p "Дискриминант равен нулю! Оба корня одинаковы x1 = x2"
	x =-b/(2*a)
	p "X1 == X2 = #{x}"
else
	p "Дискриминант больше нуля!" 
	x1 = (-b + Math.sqrt(discr))/2*a
	p "X1 = #{x1}"
	x2 = (-b - Math.sqrt(discr))/2*a
	p "X2 = #{x2}"
end

=begin
	>> 3 4 4
	x = 2


=end