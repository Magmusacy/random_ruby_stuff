def parens(n, left = Array.new(n, "("), right = Array.new(n, ")"), string = '', ary = [])
  return '' if n <= 0
  
  return string if left.empty? & right.empty?
  
  if left.length < right.length
    ary << parens(n, left, right[0..-2], string + right.last)
  end
  
  if left.length <= right.length && left.length > 0
    ary << parens(n, left[0..-2], right, string + left.last)
  end

  ary.flatten
end

# commented out code is my first solution which is working but it's terrible compared to the one that's not commented out

#def balanced_parens(n)
#  return [""] if n < 1
#  return ["()"] if n == 1
#  nums = find_nums(n)
#  ary = []
#  nums.each do |nums|
#    ary << []
#    nums.each do |num|
#      ary.last << balanced_parens(num.to_i)
#    end
#  end
#  return_ary = []
#  (ary.length).times do |i| 
#    new_el = prod(ary[i]).first.map{ |element| element.join } 
#    return_ary.push(new_el, reverse_parens(new_el))
#  end
#  (return_ary.flatten  + balanced_parens(n-1).map{ |paren| "(#{paren})" }).uniq
#end
#
#def find_nums(n, divisor = 1, return_result = "")
#  return [] if n < 1
#  return return_result.split("|").uniq.map{ |n| n.split("-") }.reject{|x| x == ""} if divisor == n
#  div = n/divisor 
#  mod = n % divisor
#  result = ""
#  div.times{ result += "#{divisor.to_s}-" }
#  result += "#{mod}" if mod > 0
#  result += "|"
#  return_result += result
#  find_nums(n, divisor + 1, return_result)
#end
#
#def reverse_parens(parens)
#  parens.map{ |string| string.reverse.chars.map{ |paren| paren == ")" ? "(" : ")" }.join} - parens
#end
#
#def prod(ary, return_ary=nil)
#  return_ary ||= [ary.shift]
#  return return_ary if ary.empty?
#  return_ary[0] = return_ary[0].product(ary.shift) 
#  prod(ary, return_ary)
#end