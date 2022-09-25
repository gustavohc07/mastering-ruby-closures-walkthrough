class SomeClass

  def method_that_calls_proc_or_lambda(procy)
    puts "calling #{proc_or_lambda(procy)} now!"
    procy.call
    puts "#{proc_or_lambda(procy)} gets called!"
  end

  def proc_or_lambda(proc_like_thing)
    proc_like_thing.lambda? ? "Lambda" : "Proc"
  end
end

c = SomeClass.new

c.method_that_calls_proc_or_lambda lambda { return }
# => calling Lambda now!
# => Lambda gets called!

c.method_that_calls_proc_or_lambda proc { return }
# => calling Proc now!

# Hmm... WHY?

# OOOH, the "return" from lambda will be handled inside the lambda. It is not going to the outer scope.

# return from a proc will leave the current context. Is like having a return in the middle
# of the code. At least, that was my understanding why.

# In the book, proc throws a LocalJumpError. This might be an old version of Ruby (2.2.X).
# I was using 2.7.2 throughout the exercises and files.

# The explanation from the book is that we are defining the proc in the "main" context and returning to it. Which is
# impossible, and that is why the "LocalJumpError" was raised.


