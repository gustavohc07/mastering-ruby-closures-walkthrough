module FileRefine
  refine File do
    def self.open(name, permission, &block)
      file = new(name, permission)

      file unless block_given?
      yield file
    ensure # if any exception happens, the file will be close, no matter what.
      file.close
    end
  end
end

using FileRefine

# irb -r ./chapter-2/file_open.rb

File.open("./chapter-2/file_open.rb", "r") do |f|
  puts f.path
  puts f.ctime
  puts f.size
end
