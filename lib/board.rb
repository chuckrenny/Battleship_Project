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
        if horizontal_placement(coordinate_array) || vertical_placement(coordinate_array)
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
    letters = coordinate_array.map { |coordinate| 
      coordinate[0] 
    } #['A', 'A', 'A']

    # numbers are increasing order && letters all the|  same
    letters.uniq.length == 1 && numbers == (numbers.first..numbers.last).to_a 
    #another array of numbers but in consecutive order
  end

  def vertical_placement(coordinate_array)
    numbers = coordinate_array.map { |coordinate|
      coordinate[1].to_i
    }

    letters = coordinate_array.map { |coordinate| 
      coordinate[0] 
    }

    # numbers are all the same && letters are in consecutive increasing order
    numbers.uniq.length == 1 && ("A".."D").each_cons(coordinate_array.count).find {|each| letters == each}
  end
end