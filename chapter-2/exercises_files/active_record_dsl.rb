# ActiveRecord::Schema.define(version: 20130315230445) do
#   create_table "microposts", force: true do |t|
#     t.string "content"
#     t.integer "user_id"
#     t.datetime "created_at"
#     t.datetime "updated_at"
#   end
# end

# Let's implement it!! Of course, a super simple version.

module ActiveRecord
  class Schema

    def self.define(version:, &block)
      instance_eval(&block)
    end

    def self.create_table(table_name, options = {}, &block)
      t = Table.new(table_name, options)
      t.instance_eval(&block)
    end
  end
end


class Table
  def initialize(name, options)
    @name = name
    @options = options
  end

  def string(value)
    puts "Creating column of type string named #{value}"
  end

  def integer(value)
    puts "Creating column of type integer named #{value}"
  end

  def datetime(value)
    puts "Creating column of type datetime named #{value}"
  end
end

ActiveRecord::Schema.define(version: 20130315230445) do
  create_table "microposts", force: true do
    string "content"
    integer "user_id"
    datetime "created_at"
    datetime "updated_at"
  end
end


puts "\n\n\nOther implementation, same results: \n\n\n"
# Other implementation:


module ActiveRecord
  class Schema

    def self.define(version:, &block)
      instance_eval(&block)
    end

    def self.create_table(table_name, options = {})
      t = Table.new(table_name, options)
      yield t
    end
  end
end


ActiveRecord::Schema.define(version: 20130315230445) do
  create_table "microposts", force: true do |t|
    t.string "content"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end
