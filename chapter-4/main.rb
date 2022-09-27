# Infinite number generator:

f = Fiber.new do
  x = 0
  loop do
    Fiber.yield x
    x += 1
  end
end

f.resume
# => 0

f.resume
# => 1

f.resume
# => 2


# Fiber.yield method returns the control to the caller. It also returns the result
