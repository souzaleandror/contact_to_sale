#!/bin/ruby

require 'json'
require 'stringio'

# Complete the insertionSort function below.
def insertionSort(arr)
  
  return 0 if arr.count <= 1

  arr_size_index = arr.size-1
  count_shifts = 0

  for i in 0..arr_size_index

    break if i == arr_size_index
    
    if arr[i] > arr[i+1]
      arr[i], arr[i+1] = arr[i+1], arr[i]
      count_shifts+=1
    end

    j = i

    while (j > 0) && arr[j-1] > arr[j]
      arr[j], arr[j-1] = arr[j-1], arr[j]
      j -=1
      count_shifts+=1
    end

  end

  count_shifts
end

fptr = File.open(ENV['OUTPUT_PATH'], 'w')

t = gets.to_i

t.times do |t_itr|
    n = gets.to_i

    arr = gets.rstrip.split(' ').map(&:to_i)

    result = insertionSort arr

    fptr.write result
    fptr.write "\n"
end

fptr.close()