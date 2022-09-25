class SpiceGirl
  def initialize(name, nick)
    @name = name
    @nick = nick
  end

  def inspect
    "#{@name} (#{@nick} Spice)"
  end

  def self.to_proc
    proc do |obj|
      name, nick = obj
      spice_girl = SpiceGirl.new(name, nick)
      spice_girl.inspect
    end
  end
end

spice_girls = [
  ["Mel B", "Scary"],
  ["Mel C", "Sporty"],
  ["Emma B", "Baby"],
  ["Geri H", "Ginger"],
  ["Vic B", "Posh"]
]

p spice_girls.map(&SpiceGirl)
