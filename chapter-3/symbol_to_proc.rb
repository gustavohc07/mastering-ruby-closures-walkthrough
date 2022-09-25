class Symbol
  def to_proc
    proc { |obj| obj.send(self) }
  end
end

words = ["hello", "world", "!"]

puts "Redefining the class"

p words.map(&:length)

module SymbolRefine # For some reason this doesn't work as supposed
  refine Symbol do
    def to_proc
      proc { |obj| obj.send(self) }
    end
  end
end

using SymbolRefine

# maybe when we call it this way, it transfers control outside the scope.
# According to Ruby Docs:

# When control is transferred outside the scope, the refinement is deactivated.
# This means that if you require or load a file or call a method that is
# defined outside the current scope the refinement will be deactivated:

# Since &:length is a syntatic sugar way of calling "to_proc" to a symbol, it will not work.

puts "\n--------\nUsing refinement\n\n"

# This is how to make the refinement work without using &:length
p words.map {|x| :length.to_proc.call(x) }
