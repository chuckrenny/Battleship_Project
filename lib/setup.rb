require './spec/spec_helper'

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

  def main_menu
    puts "Welcome to BATTLESHIP!" 
    puts "Enter p to play. Enter q to quit."
    input = gets.chomp
    if input == "q"
      return puts "See you later!"
    else
    begin_game(input)
    end
  end

  def begin_game(input)
    if input == "p"
      puts "Let's Play!"
      setup = Setup.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      setup.computer_placement(cruiser)
      setup.computer_placement(submarine)
    
      puts setup.computer.render(true)
      puts "I have laid out my ships on the grid. \n" +
            "You now need to lay out your ships \n" +
            "The Cruiser is three units long and the Submarine is two unit long"
      puts setup.player.render
      puts " Enter the squares for the Cruiser (3 spaces):  \n" +
           " Example: A1, A2, A3"
      cruiser1_placement = gets.chomp
      cruiser1 = Ship.new("Cruiser", 3)
    
      while(setup.player_placement(cruiser1, cruiser1_placement) == false)
        puts "Those are invalid cruiser coordinates. Please try again:"
        cruiser1_placement = gets.chomp
      end
      
      puts setup.player.render(true)
    
      puts " Enter the squares for the Submarine (2 spaces):  \n" +
           " Example: B1, C1"
      submarine1_placement = gets.chomp
      submarine1 = Ship.new("Submarine", 2)
    
      while(setup.player_placement(submarine1, submarine1_placement) == false)
        puts "Those are invalid submarine coordinates. Please try again:"
        submarine1_placement = gets.chomp
      end
      puts setup.player.render(true)
      
      setup.run
    end
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

    if (computer_ships.any? { |cell| cell[1].ship.sunk == false } && player_ships.any? {|cell| cell[1].ship.sunk == false})
      run
    elsif (computer_ships.all? { |cell| cell[1].ship.sunk == true } && player_ships.all? {|cell| cell[1].ship.sunk == true})
      puts "Tie Game!"
    elsif computer_ships.any? {|cell| cell[1].ship.sunk == false} == false 
      puts "Player Won!"
    else
      puts "Computer Won!"
    end
    main_menu
  end
end