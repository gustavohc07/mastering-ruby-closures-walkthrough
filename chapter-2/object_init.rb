module Twitter
  module REST
    class Client
      attr_accessor :consumer_key, :consumer_secret,
                    :access_token, :access_token_secret

      def initialize
        yield self if block_given?
      end
    end
  end
end

client = Twitter::REST::Client.new do |config|
  config.consumer_key = "YOUR_CONSUMER_KEY"
  config.consumer_secret = "YOUR_CONSUMER_SECRET"
  config.access_token = "YOUR_ACCESS_TOKEN"
  config.access_token_secret = "YOUR_ACCESS_SECRET"
end


p client

puts "\n\n-----------------------------\n\n"

# Revisiting after the instance_eval() method

module Twitter
  module REST
    class Client
      attr_accessor :consumer_key, :consumer_secret,
                    :access_token, :access_token_secret

      def initialize(&block)
        instance_eval(&block) if block_given?
      end
    end
  end
end

client = Twitter::REST::Client.new do
  consumer_key = "YOUR_CONSUMER_KEY"
  consumer_secret = "YOUR_CONSUMER_SECRET"
  access_token = "YOUR_ACCESS_TOKEN"
  access_token_secret = "YOUR_ACCESS_SECRET"
end

p client
# #<Twitter::REST::Client:0x000000014e085620>


# In the book, it is calling like the above. And it doesn't work. It might have worked in previous versions of Ruby.
# The problem is, when setting "consumer_key =" we are not triggering the setter
# we are only declaring a local variable. There are probably three ways of handling this

puts "\n\n-----------------------------\n\n"

# First solution - calling self to each attribute:

# Calling "self.consumer_key =" we are actually calling the setter.
# The thing is, which one would you prefer? This solution, or the first one in this file? It is as verbose.
# Calling self might not be as clear as calling "config.consumer_key".

client = Twitter::REST::Client.new do
  self.consumer_key = "YOUR_CONSUMER_KEY"
  self.consumer_secret = "YOUR_CONSUMER_SECRET"
  self.access_token = "YOUR_ACCESS_TOKEN"
  self.access_token_secret = "YOUR_ACCESS_SECRET"
end

p client
# #<Twitter::REST::Client:0x000000014e084a90 @consumer_key="YOUR_CONSUMER_KEY",
# @consumer_secret="YOUR_CONSUMER_SECRET", @access_token="YOUR_ACCESS_TOKEN",
# @access_token_secret="YOUR_ACCESS_SECRET">

puts "\n\n-----------------------------\n\n"

# Second: setting instance variables inside block:

# This solution might not be sound. We are accessing instance variables inside a class.
# instance_eval() allows us to do that. It throw away the entire encapsulation that classes were made of
# Still, it is a solution, but might not be a good one.

client = Twitter::REST::Client.new do
  @consumer_key = "YOUR_CONSUMER_KEY"
  @consumer_secret = "YOUR_CONSUMER_SECRET"
  @access_token = "YOUR_ACCESS_TOKEN"
  @access_token_secret = "YOUR_ACCESS_SECRET"
end

p client

puts "\n\n-----------------------------\n\n"

# Third, setting methods inside the class and calling then in the block:

# We are removing the accessor and defining methods to each of the optional keys.
# This way we are calling methods inside the block with "self" being an instance of Twitter::REST::Client.

module Twitter
  module REST
    class Client
      def initialize(&block)
        instance_eval(&block) if block_given?
      end

      def consumer_key(key=nil)
        @consumer_key ||= key
      end

      def consumer_secret(key=nil)
        @consumer_secret ||= key
      end

      def access_token(key=nil)
        @access_token ||= key
      end

      def access_token_secret(key=nil)
        @access_token_secret ||= key
      end
    end
  end
end

client = Twitter::REST::Client.new do
  consumer_key "YOUR_CONSUMER_KEY"
  consumer_secret "YOUR_CONSUMER_SECRET"
  access_token "YOUR_ACCESS_TOKEN"
  access_token_secret "YOUR_ACCESS_SECRET"
end

p client


puts "\n\n-----------------------------\n\n"


# We can give more flexibility to it as well. Having a block and\or options:


module Twitter
  module REST
    class Client
      def initialize(options = {}, &block)
        options.each { |key, value| send(key, value) }
        instance_eval(&block) if block_given?
      end

      def consumer_key(key=nil)
        @consumer_key ||= key
      end

      def consumer_secret(key=nil)
        @consumer_secret ||= key
      end

      def access_token(key=nil)
        @access_token ||= key
      end

      def access_token_secret(key=nil)
        @access_token_secret ||= key
      end
    end
  end
end

client = Twitter::REST::Client.new({consumer_key: "YOUR_CONSUMER_KEY"}) do
  consumer_secret "YOUR_CONSUMER_SECRET"
  access_token "YOUR_ACCESS_TOKEN"
  access_token_secret "YOUR_ACCESS_SECRET"
end

p client
