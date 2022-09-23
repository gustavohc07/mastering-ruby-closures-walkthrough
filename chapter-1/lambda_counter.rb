Counter = lambda do
  x = 0
  get_x = lambda { x }
  incr = lambda { x += 1 }
  decr = lambda { x -= 1 }

  { get_x: get_x, incr: incr, decr: decr }
end

# irb -r ./chapter-1/lambda_counter.rb
