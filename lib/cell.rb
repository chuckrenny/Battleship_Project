class Cell
  attr_reader :coordinate
  attr_accessor :ship
  
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @empty = true
    @fired_upon = false
  end

  def empty?
    @empty
  end

  def place_ship(ship)
    @ship = ship
    @empty = false
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if @fired_upon == false 
      @fired_upon = true
      if @ship != nil
        @ship.hit 
      end
    end
  end

  def render(show = false)
    if @fired_upon == false && show && @ship != nil
      "S"
    elsif @fired_upon == false
      "."
    elsif @ship == nil
      "M"
    elsif @ship.sunk?
      "X"
    else
      "H"
    end
  end
end