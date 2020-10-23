# Заполнить хеш гласными буквами, где значением будет являтся
# порядковый номер буквы в алфавите (a - 1).
# «A», «E», «I», «O», «U», «Y».

glasn = %w[a e i o u y]
hash = { }
alphabet = ('a'..'z').to_a

alphabet.each.with_index(1) do |a, index|
  if glasn.include?(a)
    hash[a.to_sym] = index
  end
end

puts hash.inspect
