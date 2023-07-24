class Setup
  attr_reader :computer, :player

  def initialize
    @computer = Board.new
    @player = Board.new
  end

  def computer_placement(ship)
    good_coordinates = @computer.cells.keys.combination(ship.length).to_a.find_all do |coordinates|
                         @computer.helper_placement(coordinates)
                       end
    if @computer.place(ship, good_coordinates.sample) == false
      computer_placement(ship)
    end
  end

  def player_placement(ship, coordinate_string)
    # 'A1 A2 A3'
    coordinate_array = coordinate_string.gsub(',', '').split(" ")

    @player.place(ship, coordinate_array)
  end
end