class Setup
  attr_reader :computer, :player

  def initialize
    @computer = Board.new
    @player = Board.new
  end

  def computer_placement(ship)
    cruiser_horizontal = [
      ["A1", "A2", "A3"], ["A2", "A3", "A4"],
      ["B1", "B2", "B3"], ["B2", "B3", "B4"],
      ["C1", "C2", "C3"], ["C2", "C3", "C4"],
      ["D1", "D2", "D3"], ["D2", "D3", "D4"]
    ]

    cruiser_vertical = [
      ["A1", "B1", "C1"], ["B1", "C1", "D1"],
      ["A2", "B2", "C2"], ["B2", "C2", "D2"],
      ["A3", "B3", "C3"], ["B3", "C3", "D3"],
      ["A4", "B4", "C4"], ["B4", "C4", "D4"]
    ]

    all_cruisers = cruiser_horizontal + cruiser_vertical 

    # random_placement_cruiser = all_cruisers.sample

    submarine_horizontal = [
      ["A1", "A2"], ["A2", "A3"], ["A3", "A4"],
      ["B1", "B2"], ["B2", "B3"], ["B3", "B4"],
      ["C1", "C2"], ["C2", "C3"], ["C3", "C4"],
      ["D1", "D2"], ["D2", "D3"], ["D3", "D4"]
    ]

    submarine_vertical = [
      ["A1", "B1"], ["B1", "C1"], ["C1", "D1"],
      ["A2", "B2"], ["B2", "C2"], ["C2", "D2"],
      ["A3", "B3"], ["B3", "C3"], ["C3", "D3"],
      ["A4", "B4"], ["B4", "C4"], ["C4", "D4"]
    ]

    all_submarines = submarine_horizontal + submarine_vertical 

    # random_placement_submarine = all_submarines.sample
    # require 'pry';binding.pry
    if ship.length == 3
      while(@computer.place(ship, all_cruisers.sample) == false)
        @computer.place(ship, all_cruisers.sample)
      end
    elsif ship.length == 2
      while(@computer.place(ship, all_submarines.sample) == false)
        @computer.place(ship, all_submarines.sample)
      end
    end
  end

  def player_placement(ship, coordinate_string)
    # 'A1 A2 A3'
    coordinate_array = coordinate_string.gsub(',', '').split(" ")

    @player.place(ship, coordinate_array)
  end
end