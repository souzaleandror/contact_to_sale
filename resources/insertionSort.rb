#!/bin/ruby

require 'json'
require 'stringio'

# Complete the insertionSort function below.
def insertionSort(arr)

	# faço o controle (n < 2) mas para ter certeza
	return 0 if arr.count == 1

	count_shifts = 0
    arr.sort! {|a, b| count_shifts +=1 if (((a <=> b) == 1) && (a > b)) || (((a <=> b) == -1) && (a > b)); a <=> b }
    p arr
	count_shifts
end

fptr = File.open('test.txt', 'w')

puts "Digite o número de arrays que deseja ordernar \n(Mínimo: 1 / Máximo: 15):"

t = gets.to_i

while ((t < 1) || (t > 15))
	puts "Valor deve estar entre 1 e 15. Tente novamente:"
	t = gets.to_i
end

i = 1

t.times do |t_itr|
		puts "Digite quantos elementos terá o #{i} array:"
    n = gets.to_i

    while ((n < 2) || (n > 100000))
    	puts "Tamanho do array invalído. Tente novamente:"
    	puts "Digite quantos elementos terá o #{i} array:"
    	n = gets.to_i
    end

    puts "Digite o valor de cada elemento, separado por espaço simples."

    arr = gets.rstrip.split(' ').map(&:to_i)

    while arr.count != n 
    	puts "Número de elementos não corresponde ao valor digitado antes.\n"
    	puts "Digite #{n} elementos, seperados por espaço simples."	
    	arr = gets.rstrip.split(' ').map(&:to_i)
    end

    result = insertionSort arr

    puts "Serão #{result.to_s} trocas \n\n"

    fptr.write result
    fptr.write "\n"
    i += 1
end

fptr.close()