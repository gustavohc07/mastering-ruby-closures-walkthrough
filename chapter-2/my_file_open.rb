# File.open(filename, mode) do

# end

module RefineFile
  refine File do
    def self.open(filename, mode)
      file = new(filename, mode)

      return file unless block_given?

      yield file
    ensure # any error, will ensure the file was closed
      file.close
    end
  end
end

using RefineFile

# file = File.open("./chapter-2/my_file_open.rb", "r")
# puts file
# file.close

file = File.open("./chapter-2/my_file_open.rb", "r") do |f|
  puts f.path
  puts f.ctime
  puts f.size
end
