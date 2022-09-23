# Exercises

=begin
  1-) What is the definition of a closure
    It is a function whose body references some variable that is defined in the parent scope (a free variable)

  2-) Identify the free variable in the following:

    def is_larger_than(amount)
      lambda do |a|
        a > amount
      end
    end

    Amount is the free variable. It is defined in the parent scope and used inside lambda.
=end

# 3 Work music problem

new_db = lambda do
  data = {}

  dump = -> { data }
  insert = ->(artist, album_title) { data[artist] = album_title }
  delete = ->(artist) { data[artist] = nil }

  {insert: insert, delete: delete, dump: dump}
end

# The API:

db = new_db.call

db[:insert].call("Eagles", "Hell Freezes Over")

db[:insert].call("Pink Floyd", "The Wall")

p db[:dump].call

db[:delete].call("Pink Floyd")

p db[:dump].call


# 4 - Redefine complement method to a lambda

def complement(predicate)
  lambda do |value|
    not predicate.call(value)
  end
end

complement = lambda do |predicate|
  lambda do |value|
    not predicate.call(value)
  end
end

is_even = ->(x) { x % 2 == 0 }

p complement.call(is_even).call(4)

p complement.call(is_even).call(5)

# 5 - Make reduce return an array of elements instead of a single value

# my implementation
value = [1,2,3,4,5].reduce([]) do |acc, x|
  acc << x * 2
end

p value

# We were suposse to use reducer...

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

p reducer.call([], [1,2,3,4,5], lambda {|acc, n| acc << n * 2 })
