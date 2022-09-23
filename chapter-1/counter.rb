class Counter
  def initialize
    @counter = 0
  end

  def get_counter
    @counter
  end

  def incr
    @counter += 1
  end

  def decr
    @counter -= 1
  end
end

c = Counter.new

c.incr
p c.get_counter
c.incr
c.incr
c.decr
p c.get_counter
