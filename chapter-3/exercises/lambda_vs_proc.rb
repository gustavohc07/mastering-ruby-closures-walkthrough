# How can you tell the difference between a Proc and a lambda in Ruby?

# There are two different ways to know:
  # 1 - lambdas cares about the number of arguments you send them. So if you call a lambda with
  # extra arguments, it is going to complain

  # 2 - you can call lambda? method to determine if you are calling a lambda or a proc

pr = proc { puts "Hey" }

p pr.lambda?

lb = -> { puts "Hey" }
p lb.lambda?

# There is also the returning context of each other. But that is harder to guess.



# Class Proc {} is a class. Lambdas are procs. Lambdas are procs but procs not necessarily are lambdas
