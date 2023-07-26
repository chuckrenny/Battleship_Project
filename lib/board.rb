class Board
  attr_reader :cells

  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
     }
     @numbers = (1..4).to_a
     @letters = ("A".."D").to_a
  end

  def create_board(length, width)
    @numbers = (1..width).to_a
    @letters = ("A"..length).to_a
    places = @letters.product(@numbers)
    tiles = places.each_with_object({}) {|cell, hash| hash[cell.join] = Cell.new(cell.join)}
    @cells = tiles
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinate_array)
    if coordinate_array.length == ship.length
      helper_placement(coordinate_array) && coordinate_array.all? {|cell| @cells[cell].empty?}
    else
      false 
    end 
  end

  def helper_placement(coordinate_array)
    numbers = coordinate_array.map { |coordinate| coordinate[1].to_i} 
    letters = coordinate_array.map { |coordinate| coordinate[0] } 
    (letters.uniq.length == 1 && numbers == (numbers.first..numbers.last).to_a) || 
    (numbers.uniq.length == 1 && ("A"..@letters.last).each_cons(coordinate_array.count).any? {|each| letters == each})
  end

  def place(ship, coordinate_array)
    if valid_placement?(ship, coordinate_array)
      coordinate_array.each do |cell|
        @cells[cell].place_ship(ship) 
      end
    else
      false
    end
  end

  def render(player = false)
    places = @letters.product(@numbers) 

    board = 
      game = []
      @letters.map do |lett|
        row = []
        places.each do |place|
          if place[0] == lett
            row << place.join
          end
        end
        game << row
      end
      game

    projection = ["  #{@numbers.join(" ")} \n"]
    board.each_with_index do |row, index|
      new_row = row.map do |cell|
        @cells[cell].render(player)
      end
      projection.push("#{@letters[index]} " + new_row.join(" ") + " \n")
    end
    projection.join("")
  end
end