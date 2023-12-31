class Board
  attr_reader :cells, :numbers, :letters

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
      helper_placement(coordinate_array)
    else
      false 
    end 
  end

  def helper_placement(coordinate_array)
    numbers = coordinate_array.map { |coordinate| coordinate[1..-1].to_i} 
    letters = coordinate_array.map { |coordinate| coordinate[0] } 
    ((letters.uniq.length == 1 && numbers == (numbers.first..numbers.last).to_a) || 
    (numbers.uniq.length == 1 && ("A"..@letters.last).each_cons(coordinate_array.count).any? {|each| letters == each})) &&
    coordinate_array.all? {|cell| @cells[cell].empty?}
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

    projection = ["  " + @numbers.map { |n| 
        if n.to_s.length < 2 
          " #{n}"
        else 
          n.to_s 
        end
        }.join(" ") + " \n"]

    board.each_with_index do |row, index|
      new_row = row.map do |cell|
        cell_content = @cells[cell].render(player)
        if cell_content.length < 2 
            cell_content = " " + cell_content
        end
        cell_content
      end
      projection.push("#{@letters[index]} " + new_row.join(" ") + " \n")
    end
    projection.join("")
  end

  def adjacent_cells(cell)
    letters = ("A"..@cells.keys.last[0]).to_a
    numbers = (1..@cells.keys.last[1].to_i).to_a

    # split key into letter and number component 'A' '1'
    letter = cell[0]
    number = cell[1..-1]

    # find the indices of the letter and number in their respective arrays
    letter_index = letters.index(letter)
    number_index = numbers.index(number.to_i)

    # calculate the keys for adjacent cells
    adjacent_keys = []

    # input key if it does not wrap
    if number_index - 1 >= 0
      adjacent_keys << [letter, numbers[number_index - 1]].join  # left cell
    end
    if number_index + 1 < numbers.length
      adjacent_keys << [letter, numbers[number_index + 1]].join  # right cell
    end
    if letter_index - 1 >= 0
      adjacent_keys << [letters[letter_index - 1], number].join  # upper cell
    end
    if letter_index + 1 < letters.length
    adjacent_keys << [letters[letter_index + 1], number].join  # lower cell
    end

    # returns array for all keys included in the board that have not been fired_upon
    adjacent_keys.select { |key| valid_coordinate?(key) && !@cells[key].fired_upon?}
  end
end