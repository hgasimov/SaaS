def sum(array)
  s = 0
  array.each { |i|
    s += i
  }
  return s
end

def max_2_sum(array)
  if array.length == 0
    return 0
  elsif array.length == 1
    return array[0]
  else
    array.sort!
    return array[-2] + array[-1]
  end
end

def sum_to_n?(array, n)
  if array.length == 0
    return n == 0
  end
  
  if array.length == 1
    return array[0] == n
  end
  
  for i in 0...array.length
    for j in i+1...array.length
      if array[i] + array[j] == n
        return true
      end
    end
  end
  
  return false
end
