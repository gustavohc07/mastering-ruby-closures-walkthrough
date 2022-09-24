# Fixnum#times

module FixnumRefine
  refine Fixnum do
    def times
      acc = self
      while acc > 0
        yield
        acc -= 1
      end
      self
    end
  end
end

5.times { puts "Hello! From Fixnum#times" }

puts
using FixnumRefine

5.times { puts "Hello! From Refined Fixnum" }
