class Ship
  attr_reader :name,
              :length,
              :health,
              :sunk

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
    @sunk = false
  end

  def sunk?
    @sunk
  end

  def hit
    @health -= 1 if !@sunk
    @sunk = true if @health == 0
  end

end