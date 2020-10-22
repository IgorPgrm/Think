# Заполнить хеш гласными буквами, где значением будет являтся
# порядковый номер буквы в алфавите (a - 1).
# «A», «E», «I», «O», «U», «Y».

glasn = %w[a e i o u y]
hash = Hash.new
alphabet = ('a'..'z').to_a

alphabet.each_with_index do |a, index|
  if glasn.include?(a)
    hash[a.to_sym] = index+1
  end
end

puts hash.inspect
