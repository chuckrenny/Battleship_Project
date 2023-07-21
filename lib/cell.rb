class Cell
  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @empty = true
  end

  def empty?
    @empty
  end

  def place_ship(input)
    @ship = input
    @empty = false
  end
end