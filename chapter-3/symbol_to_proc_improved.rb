# class Symbol
#   def to_proc
#     lambda { |obj, args=nil| obj.send(self, *args) }
#   end
# end


class Symbol
  def to_proc
    proc { |obj, args| obj.send(self, *args) }
  end
end

words = ["hello", "world", "!"]

p words.map(&:length)

p [2,2,3].inject(1) { |result, element| result + element}

p [2,2,3].inject(1, &:+)
