def do_it(x, y)
  yield(x, y)
end

p do_it(2, 3) { |x, y| x + y } # we are encapsulating behavior.

value = do_it("Hello,", "developer!") do |greeting, title|
  "#{greeting} #{title}"
end

# We didn't change our method "do_it", but we change how it behaves inside the block.

p value

=begin

  Blocks act like anonymous functions
  It also carries around the context in which it was defined.

=end

def chalkboard_gag(line, repetition)
  repetition.times { |x| puts "#{x}: #{line}"} # line is a free variable. Outer scope of the block.
end

# Block Patter #1: Enumeration

%w(look ma no for loops).each do |x|
  puts x
end


# Block Pattern #2: Managing Resources

f = File.open("any_file.txt", 'w') do |f|
  f << "Yes, this is a line"
  f << "Yes, this is another line!"
end # we open and closed the file when we are using blocks.

# Now, let's implement a File.open method


# Block Pattern #3: Beautiful Object Initialization
