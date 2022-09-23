=begin

Lexical scoping is what we already know with a cool name.
Whichever assignment to a variable that is the closest gets that value. Also, it is all limited by scope.

It serves to answer one question: What is the value of this variable at this line?

=end

# Lexical Scoping

var = "Hello "

3.times do
  suffix = "world!"
  puts "#{var}#{suffix}"
end

# If we call "var" here, we can access it:

puts var

# but if we call suffix, we can't because it is on a limited scope.


# Simulating classes with closures

=begin
  Before that, the definition of closure:
    1 - It needs to be a function (proc, lambda, block)
    2 - Whose body references some variable that
    3 - is declared in a parent scope (a free variable)
=end
