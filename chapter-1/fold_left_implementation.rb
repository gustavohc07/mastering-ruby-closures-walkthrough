# Fold Left A.K.A Enumerable#reduce in Ruby

[1,2,3,4,5].reduce(10) { |acc, x| p "#{acc}, #{x}"; acc + x }

# Implement adder.call(10, [1,2,3,4,5]) => 25

adder = lambda do |acc, arr| # not a closure
  if arr.empty?
    acc
  else
    new_acc = acc + arr.first
    adder.call(new_acc, arr.drop(1))
  end
end

p adder.call(10, [1,2,3,4,5])

mult = lambda do |acc, arr| # not a closure (no free variable)
  if arr.empty?
    acc
  else
    new_acc = acc * arr.first
    mult.call(new_acc, arr.drop(1))
  end
end

p mult.call(5, [1,2,3,4,5])

# My implementation:
reducer = lambda do |acc, arr, binary_operation| # not a closure, no free variable
  if arr.empty?
    acc
  else
    new_acc = acc.send(binary_operation, arr.first)
    reducer.call(new_acc, arr.drop(1), binary_operation)
  end
end

puts "Reducer"
p reducer.call(5, [1,2,3,4,5], "*")
p reducer.call(5, [1,2,3,4,5], "+")

# Book first implementation:

reducer = lambda do |acc, arr, binary_function| # not a closure, no free variable
  if arr.empty?
    acc
  else
      reducer.call(binary_function.call(acc, arr.first), arr.drop(1), binary_function)
  end
end

p reducer.call(5, [1,2,3,4,5], lambda {|x, y| x + y})


reducer = lambda do |acc, arr, binary_function| # a closure, binary_function is a free variable to reducer_aux
  reducer_aux = lambda do |acc, arr|
    if arr.empty?
      acc
    else
      new_acc = binary_function.call(acc, arr.first)
      reducer_aux.call(new_acc, arr.drop(1))
    end
  end

  reducer_aux.call(acc, arr) # we need to call it here, otherwise it will never happen. Imagine as a method definition. If you don't call the method, it will not be executed
end

p reducer.call(5, [1,2,3,4,5], ->(x, y) { x * y })
