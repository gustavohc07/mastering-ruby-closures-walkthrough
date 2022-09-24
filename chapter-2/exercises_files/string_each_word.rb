module RefineString
  refine String do
    def each_word
      x = 0
      words_array = self.split
      while words_array.size > x
        yield words_array[x]
        x += 1
      end
    end
  end
end

using RefineString

testing = "Nothing lasts forever but cold November Rain".each_word do |x|
  puts x
end
