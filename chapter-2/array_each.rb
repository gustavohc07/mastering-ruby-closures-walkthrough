module ArrayRefinement
  refine Array do
    def each
      index = 0
      while index < self.size
        yield self[index]
        index += 1
      end
      self
    end
  end
end

[1,2,3,4].each { |x| p x }
puts
using ArrayRefinement

[1,2,3,4].each { |x| p x }
# 1
# 2
# 3
# 4
# => [1,2,3,4]
