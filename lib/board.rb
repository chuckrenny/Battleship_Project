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
    end

    def valid_coordinate?(coordinate)
      @cells.keys.include?(coordinate)
    end

    def valid_placement?(ship, coordinate_array)
      if coordinate_array.length == ship.length
        if helper_placement(coordinate_array) && 
        coordinate_array.all? {|cell| @cells[cell].empty?}
          true
        else 
          false
        end
      else
        false 
      end 
    end

  def helper_placement(coordinate_array)
    # pull out all the numbers, need to be in increasing order
    numbers = coordinate_array.map { |coordinate| coordinate[1].to_i} 

    # pull out all the letters, need to be all the same
    letters = coordinate_array.map { |coordinate| coordinate[0] } 

    # horizontal: numbers are increasing order && letters all the same
    (letters.uniq.length == 1 && numbers == (numbers.first..numbers.last).to_a) || 
    # vertical: numbers are all the same && letters are in consecutive increasing order
    (numbers.uniq.length == 1 && ("A".."D").each_cons(coordinate_array.count).any? {|each| letters == each})
  end

  def place(ship, coordinate_array)
    if valid_placement?(ship, coordinate_array)
      coordinate_array.each do |cell|
        @cells[cell].place_ship(ship) 
      end
    end
  end

  def render(player = false)
    board_size = 4
    alphabet = ("A".."Z").to_a
    nums = (1..board_size).to_a
    letts = ("A"..alphabet[board_size - 1]).to_a
    places = letts.product(nums)

    board = 
      game = []
      letts.map do |lett|
        row = []
        places.each do |place|
          if place[0] == lett
            row << place.join
          end
        end
        game << row
      end
      game
    
    # [
    #   ["A1", "A2", "A3", "A4"],
    #   ["B1", "B2", "B3", "B4"],
    #   ["C1", "C2", "C3", "C4"],
    #   ["D1", "D2", "D3", "D4"]
    # ]

    # final projection
    projection = ["  #{nums.join(" ")} \n"]
    board.each_with_index do |row, index|
      new_row = row.map do |cell|
        @cells[cell].render(player)
      end

      projection.push("#{letts[index]} " + new_row.join(" ") + " \n")
    end

    projection.join("")
    # [
    #   ["  #{nums.join(" ")} \n"],
    #   ["#{letts[index]} " + row.join(" ") + " \n"],
    #   ["#{letts[index]} " + row.join(" ") + " \n"],
    #   ["#{letts[index]} " + row.join(" ") + " \n"],
    #   ["#{letts[index]} " + row.join(" ") + " \n"]
    # ]
  end
end