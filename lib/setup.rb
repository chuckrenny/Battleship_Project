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
    coordinate_array = coordinate_string.gsub(',', '').split(" ")

    @player.place(ship, coordinate_array)
  end

  def turn
    @computer.render(true) + @player.render(true)
  end

  def run
    puts turn
    puts "Enter a valid coordinate for your shot:"
    player_shot = gets.chomp

    while (!computer.valid_coordinate?(player_shot) || computer.cells[player_shot].fired_upon? == true)
      puts "Not a valid coordinate. Please try again"
      player_shot = gets.chomp
    end

    computer.cells[player_shot].fire_upon
    sample_computer_shot = player.cells.keys.sample
    while player.cells[sample_computer_shot].fired_upon? == true
      sample_computer_shot = player.cells.keys.sample
    end
    player.cells[sample_computer_shot].fire_upon

    if computer.cells[player_shot].render == 'M' 
      puts "Your shot on #{computer.cells[player_shot].coordinate} was a miss."
    elsif computer.cells[player_shot].render == 'H'
      puts "Your shot on #{computer.cells[player_shot].coordinate} was a miss-guided HIT!"
    elsif computer.cells[player_shot].render == 'X'
      puts "Your shot on #{computer.cells[player_shot].coordinate} sunk my #{computer.cells[player_shot].ship.name}"
    end

    if player.cells[sample_computer_shot].render == 'M' 
      puts "My shot on #{player.cells[sample_computer_shot].coordinate} was a miss."
    elsif player.cells[sample_computer_shot].render == 'H'
      puts "My shot on #{player.cells[sample_computer_shot].coordinate} was a HIT!"
    elsif player.cells[sample_computer_shot].render == 'X'
      puts "My shot on #{player.cells[sample_computer_shot].coordinate} sunk your #{player.cells[sample_computer_shot].ship.name}"
    end

    computer_ships = computer.cells.find_all { |cell, cell_object| !cell_object.empty? }
    player_ships = player.cells.find_all { |cell, cell_object| !cell_object.empty? }
    # require 'pry';binding.pry
    if (computer_ships.any? { |cell| cell[1].ship.sunk == false } && player_ships.any? {|cell| cell[1].ship.sunk == false})
      run
    elsif computer_ships.any? {|cell| cell[1].ship.sunk == false} == false 
      puts "Player Won!"
    else
      puts "Computer Won!"
    end
  end
end