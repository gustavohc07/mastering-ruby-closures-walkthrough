module RefineString
  refine String do
    def each_word
      words_array = self.split
      yield words_array
    end
  end
end

using RefineString

testing = "Nothing lasts forever but cold November Rain".each_word do |x|
  puts x
end
