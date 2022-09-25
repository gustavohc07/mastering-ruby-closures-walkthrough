=begin

  We can call Procs in 4 different ways:

    1 - Proc#call(args)
    2 - .(args)()
    3 - Threequals
    4 - Lambdas

=end

# proc methdo comes from Kernel.

p = proc { |x, y| x + y }

p = Kernel.proc { |x, y| x + y }

p = Proc.new { |x, y| x + y }

## Proc#call(args)
p.call("oh", "ai")

## .(args)()
p.("oh", "ai") # I don't like this way... it is the same as above.


# if you define a "call" inside a class, we automatically inherit the above
# way of calling "procs"

class Carly
  def call(who)
    "call #{who}, maybe"
  end
end

c = Carly.new
c.("me") # => "call me, maybe" . I think The author was hitting on you, Carly.

# This is quite interesting. It is quite the same as a contract that, if you implement
# call, we are able to use the .(args). Weird, though. Where does this come from? Is it a call back?
# Does it come from "Class" class? Baisc Object class? Better, is it from Kernel?

# There is a "method_added" in Kernel private methods. Is this where we might find something?

## Threequals

p === ["oh", "ai"]

# This allow us to use procs in a case statement.
# Remember that a case statement do a === comparisson with the "case" argument and the "when" argument.

even = proc { |x| x % 2 == 0 }

case 11
  when even
    "number is even"
  else
    "number is odd"
end

# even === 11


## Lambdas

# A lambda is a Proc object, but a Proc object not necessarily is a lambda.

l = lambda { |x, y| x + y }
# or
l = ->(x, y) { x + y }

l.call(1,2)
l.(1,2)
l[1,2]


=begin

  The difference between lambda and proc
    - arity
    - return semantics

Arity refers to the number of arguments a function takes
  - Procs allows you to supply less or more arguments than needed. It will
  parity the arguments with the arguments in the proc.
      proc {|x| puts x }.call(1,2,3,4) -> this will assign 1 to x and returns no error
      lambda {|x| puts x }.call(1,2,3,4) -> This will throw an ArgumentError.


Return Semantics:
  Proc always returns from the context it was created. Look at "some_class.rb"
=end


# How Symbol#to_proc workds - Other files

# Currying with Procs

puts "\n\n Currying \n\n"

discriminant = lambda {|a,b,c| b**2 - 4*a*c }
p discriminant.call(5,6,7)

discriminant = lambda { |a| lambda { |b| lambda { |c| b ** 2 - 4*a*c } } }
p discriminant.call(5).call(6).call(7)
# Remember from the Haskell book, the lambda operation. Head and body of functions

=begin
Step by step on the call:

This is lambda calculation:

lambda { |a| lambda { |b| lambda { |c| b ** 2 - 4*a*c } } } (5) (6) (7)
  lambda {|a|} is head and the rest the body

lambda { |b| lambda {|c| b ** 2 - 4*5*c } } (6) (7)
  lambda {|b|} is the head and the rest the body

lambda { |c| 6 ** 2 - 4*5*c } (7)
  lambda {|c|} is the head and the rest the body

6 ** 2 - 4*5*7

-104 => Normalized function.

=end

discriminant = lambda {|a,b,c| b**2 - 4*a*c }.curry
p discriminant.call(5).call(6).call(7)

=begin

  From Mats:
  I consider this method (Proc#curry) to be trivial and should be
  treated like an Easter egg for functional programming kids.

=end

sum = lambda do |fun, start, stop|
  (start..stop).inject { |sum, x| sum + fun.call(x) }
end

sum_ints = sum.curry.call(lambda { |x| x })
p sum_ints.call(1,10)

sum_squares = sum.curry.call(lambda {|x| x * x })
p sum_squares.call(1,10)

sum_of_cubes = sum.curry.call(lambda { |x| x * x * x })
p sum_of_cubes.call(1,10)


