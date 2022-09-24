module RefineArray
  refine Array do
    def map
      new_array = []
      each do |n|
        new_array << (yield n)
      end
      new_array
    end

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

using RefineArray

testing = %w(look ma no for loops).map do |x|
  x.upcase
end

p testing
