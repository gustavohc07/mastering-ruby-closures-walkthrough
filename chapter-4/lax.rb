# Instead of opening Enumerator::Lazy class, we are going to use Lax

module Enumerable # we are defining this here because our caller is an Enumerable.
  def lax
    Lax.new(self)
  end
end

class Lax < Enumerator

  def initialize(receiver)
    super() do |yielder| # we are actually turning our internal iteration to an external iteration
      begin
      receiver.each do |val|
        if block_given?
          yield(yielder, val)
        else
          # puts "Add: #{val}"
          yielder << val # <<() is an alias to the yield() method.
        end
      end
    rescue StopIteration
    end
  end

    def map(&block)
      Lax.new(self) do |yielder, val|
        yielder << block.call(val)
      end
    end

    def take(n)
      taken = 0
      Lax.new(self) do |yielder, val|
        if taken < n
          yielder << val
          taken += 1
        else
          raise StopIteration
        end
      end
    end

    def select(&block)
      Lax.new(self) do |yielder, val|
        if block.call(val)
          yielder << val
        end
      end
    end

    def drop(n)
      Lax.new(self) do |yielder, val|
        enum = self.take(n).to_a
        unless enum.include? val
          yielder << val
        end
      end
    end
  end
end



# How the client will use our code?

p 1.upto(Float::INFINITY)
  .lax
  .map { |x| x * x }
  .map { |x| x + 1 }
  .take(5)
  .to_a

# => [2, 5, 10, 17, 26]

p 1.upto(Float::INFINITY)
  .lax
  .take(5)
  .to_a



# Exercises:

# 1 - Implement select()

p 1.upto(Float::INFINITY)
  .lax
  .select { |x| x > 5 }
  .take(7)
  .to_a

# 2 - Implement drop()

p 1.upto(Float::INFINITY)
  .lax
  .drop(3)
  .take(7)
  .to_a
