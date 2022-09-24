# 4

module Redis
  class Server
  # ... more code ...
    def run
      loop do
        session = @server.accept
        begin
          return if yield(session) == :exit
        ensure
          session.close
        end
      end
    rescue => ex
      $stderr.puts "Error running server: #{ex.message}" $stderr.puts ex.backtrace
    ensure
      @server.close
    end
    # ... more code ...
  end
end

=begin

Notice the similarities to the File.open() example.
Does run() require a block to be passed in? Yes
How is the return result of the block used? Its return is compared to a symbol.
How could this code be called? Redis::Server.new.run {|session| # do something }

=end
