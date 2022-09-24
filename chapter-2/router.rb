class Router
  def initialize
    yield self if block_given?
  end

  def match(route)
    puts route
  end
end

# End goal print:
  # => {"/about"=>"home#about"}
  # => {"/users"=>"users#index"}

# First let's implement this:
routes = Router.new do |r|
  r.match '/about' => 'home#about'
  r.match '/users' => 'users#index'
end

routes

puts "\n\n----------------------------\n\n"

class Router
  def initialize(&block) #-> Convert block to proc calling to_proc method on block
    instance_eval &block if block_given?
  end

  def match(route)
    puts route
  end
end

# Now we want this:
routes = Router.new do
  p self # if we don't use instance_eval(), self is main. With instance eval we are telling ruby to evaluates code in the context of the instance
  match '/about' => 'home#about'
  match '/users' => 'users#index'
end

routes

