require './spec/spec_helper'

class Setup
    attr_reader :computer, :player, :intelligent_shot

  def initialize
    @computer = Board.new
    @player = Board.new
    @game_over = false
    @player_ships = []
    @computer_ships = []
    @intelligent_shot = []
  end

  def computer_placement(ship)
    head_location = @computer.cells.find_all { |cell| cell[1].empty? }.sample[0]
    possible_placements = [[head_location], [head_location]]
    count = 0
    (ship.length - 1).times do
      if possible_placements[0][count] != nil
        letter_1, number_1 = possible_placements[0][count].split("")
        number_index_1 = @computer.numbers.index(number_1.to_i)
        possible_placements[0] << [letter_1, @computer.numbers[number_index_1 + 1]].join if number_index_1 + 1 < @computer.numbers.length
      end
      if possible_placements[1][count] != nil
        letter_2, number_2 = possible_placements[1][count].split("")
        letter_index_2 = @computer.letters.index(letter_2)
        possible_placements[1]  << [@computer.letters[letter_index_2 + 1], number_2].join if letter_index_2 + 1 < @computer.letters.length
      end
      count += 1
    end
    good_coordinates = possible_placements.find_all { |coordinates| @computer.valid_placement?(ship, coordinates) }
    if !good_coordinates.empty?
      @computer.place(ship, good_coordinates.sample)
    else
      computer_placement(ship)
    end
  end

  def player_placement(ship, coordinate_string)
    coordinate_array = coordinate_string.gsub(',', '').split(" ")

    @player.place(ship, coordinate_array)
  end

  def board_selection(length, width)
    @computer.create_board(length, width)
    @player.create_board(length, width)
  end

  def ship_creation(name, length)
    @player_ships << Ship.new(name, length)
    @computer_ships << Ship.new(name, length)
  end

 
  def main_menu
    loop do
      puts <<-'EOF'
                                                                                                                                   _.
                                                                                                                            _.--"' |
                                                                                                                      _.--"'       |
                                                                                                                _.--"'      _..,.  |
                                                                                                          _.--"'            .==; '.|
                                                                                                    _.--"'                     :   |'.
                                                                                              _.--"'                            ;  |  '.
                                                                                        _.--"'                                  :  |    '.
                                                                                  _.--"'                                         ; |      '.
                                                                            _.--"'                         _.                    : |        '.
                                                                      _.--"'                         _.--^"  :                   q I     --mmm--
                                                                _.--"'                              ;      _,.;_                 |_I____._\___/___._.__
                                                          _.--"'                                    :_.--^"   :_]                |______|     ==" " "_|'
                                                  |__.--"'                                           ;         ;|                |;I H| |_______'(|)|
                                              .   | :                                                :     _   :|                |:I_H|_|______[ '._|    _.---.______
                                              I   | ;             ,    \                    \         ;__ [_]___;                |||____________| '_|    \|   ;""         |
                       ______.---._    ______ I  /|:        \     ;\    \                    \      ,d.-^'|| '-.b.     ___       L| I|  |"  |   |_[_|_X__[|___:_,.-^>_.---.______             /|
;                          "":"|'|/    _\--/  I_/_|;         \    :/\ __nm__                _nm   _d______||______b.__EEEE3       | I|__| m |___|__H_____|_ m__|'^|"  \|  ;""                //|
;      ______.---._<^-.,_____;___|]__\|____|_|I___|] .--_____nm____; |_dHH|_|.-           |dHH|_|,-======''==_===;===|====|______|_I|__|_W_|___|__H_____^__W__|__|____|___:___,.--._nnn__m__//_o
:\         "":   |/ "|  |   __ m ___ .d88b. H m m || |_|-|-|-|-|-|-|  H*''|  .mmmmmmmmm^^" '|m[]H"m""""""|   |_| []  [_]   /*  *  * * * * *|_|'"7 | *  *   *   *   *  *  *  *  *  *     .V.    ;
:_\__,.,_n_m_;___|]_I|_[|__[__]W_____'Y88P'_H_W_W_||_|_|_|_|_|_|_|_|__H&[]|_____^MMMM^______|W__H%$&$__I_____ -'________.-'                | | /  |                                    ^(8)-  ;
|<    H  * * *  * *  * *  *  * *  * * * * * * * *  *  *  *  *  *   *   *  *  *  *                                                                                       *  *  *   *  *       :
|  _|_H_|_                                           ___________________________________________________________________________________                                                    ;
'-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------''
EOF
 
        
puts "_________/\\\\\\\\\\\\\\\\\\\\\\\\\\_______/\\\\\\\\\\\\\\\\\\_____/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\__/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\__/\\\\\\______________/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\_____/\\\\\\\\\\\\\\\\\\\\\\____/\\\\\\________/\\\\\\__/\\\\\\\\\\\\\\\\\\\\\\__/\\\\\\\\\\\\\\\\\\\\\\\\\\___        
        _\\/\\\\\\/////////\\\\\\___/\\\\\\\\\\\\\\\\\\\\\\\\\\__\\///////\\\\\\/////__\\///////\\\\\\/////__\\/\\\\\\_____________\\/\\\\\\///////////____/\\\\\\/////////\\\\\\_\\/\\\\\\_______\\/\\\\\\_\\/////\\\\\\///__\\/\\\\\\/////////\\\\\\_       
         _\\/\\\\\\_______\\/\\\\\\__/\\\\\\/////////\\\\\\_______\\/\\\\\\_____________\\/\\\\\\_______\\/\\\\\\_____________\\/\\\\\\______________\\//\\\\\\______\\///__\\/\\\\\\_______\\/\\\\\\_____\\/\\\\\\_____\\/\\\\\\_______\\/\\\\\\_      
          _\\/\\\\\\\\\\\\\\\\\\\\\\\\\\\\__\\/\\\\\\_______\\/\\\\\\_______\\/\\\\\\_____________\\/\\\\\\_______\\/\\\\\\_____________\\/\\\\\\\\\\\\\\\\\\\\\\_______\\////\\\\\\_________\\/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\_____\\/\\\\\\_____\\/\\\\\\\\\\\\\\\\\\\\\\\\\\/__     
           _\\/\\\\\\/////////\\\\\\_\\/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\_______\\/\\\\\\_____________\\/\\\\\\_______\\/\\\\\\_____________\\/\\\\\\///////___________\\////\\\\\\______\\/\\\\\\/////////\\\\\\_____\\/\\\\\\_____\\/\\\\\\/////////____    
            _\\/\\\\\\_______\\/\\\\\\_\\/\\\\\\/////////\\\\\\_______\\/\\\\\\_____________\\/\\\\\\_______\\/\\\\\\_____________\\/\\\\\\_____________________\\////\\\\\\___\\/\\\\\\_______\\/\\\\\\_____\\/\\\\\\_____\\/\\\\\\_____________   
             _\\/\\\\\\_______\\/\\\\\\_\\/\\\\\\_______\\/\\\\\\_______\\/\\\\\\_____________\\/\\\\\\_______\\/\\\\\\_____________\\/\\\\\\______________/\\\\\\______\\//\\\\\\__\\/\\\\\\_______\\/\\\\\\_____\\/\\\\\\_____\\/\\\\\\_____________  
              _\\/\\\\\\\\\\\\\\\\\\\\\\\\\\/__\\/\\\\\\_______\\/\\\\\\_______\\/\\\\\\_____________\\/\\\\\\_______\\/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\_\\/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\_\\///\\\\\\\\\\\\\\\\\\\\\\/___\\/\\\\\\_______\\/\\\\\\__/\\\\\\\\\\\\\\\\\\\\\\_\\/\\\\\\_____________ 
               _\\/////////////____\\///________\\///________\\///______________\\///________\\///////////////__\\///////////////____\\///////////_____\\///________\\///__\\///////////__\\///______________"
                                                                                                                                                                                                
      
      puts "Welcome to BATTLESHIP!" 
      puts "Enter p to play. Enter q to quit."
      input = gets.chomp
      if input == "p"
        @computer = Board.new
        @player = Board.new
        @game_over = false
        @player_ships = []
        @computer_ships = []
        @intelligent_shot = []
        begin_game
      elsif input == "q"
        puts "See you later!"
        exit(0)
      else
        puts "Invalid input, please try again."
      end
    end
  end 

  def begin_game
    puts "Let's Play!"
    puts "Would you like to select a board size?  y/n"
    board = gets.chomp.downcase
    while board != "n" && board != "y"
      puts "Invlaid input, try again."
      board = gets.chomp.downcase
    end
    if board == "y"
      puts "How long should the board be?
      Input any letter between D and Z."
      length = gets.chomp.capitalize
      puts "How wide should the board be?
      Input any number between 4 and 26."
      width = gets.chomp.to_i
      board_selection(length, width)
    end
    puts "Would you like to create your own ship? y/n
    Please note: If you choose this route, we will both only play with the ships you made."
    make = gets.chomp.downcase
    while make != "n" && make != "y"
      puts "Invalid input, try again."
      make = gets.chomp.downcase
    end
    if make == "y"
      loop do 
        puts "Please name your ship."
        name = gets.chomp
        puts "How long will the ship be?"
        health = gets.chomp.to_i
        ship_creation(name, health)
        puts "Would you like to make another? y/n"
        more = gets.chomp.downcase
        while more != "y" && more != "n"
          puts "Invalid input, try again."
          more = gets.chomp.downcase
        end
        if more == "n"
          break
        end
      end
    else
      @computer_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
      @player_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    end

    @computer_ships.each { |ship| computer_placement(ship) }
    
    puts @computer.render(true)
    puts "I have laid out my ships on the grid. \n" +
      "You now need to lay out your ships \n" +
      if make != "y"
        "The Cruiser is three units long and the Submarine is two unit long"
      else
        "Lets place what you created"
      end
    count = 0  

    loop do
      puts @player.render(true)
      puts " Enter the squares for the #{@player_ships[count].name} (#{@player_ships[count].length} spaces):  \n" +
        " Example: #{(@player.cells.keys[0]..@player.cells.keys[@player_ships[count].length - 1]).to_a.join(" ")}"
      placement = gets.chomp
      while(player_placement(@player_ships[count], placement) == false)
        puts "Those are invalid coordinates. Please try again:"
        placement = gets.chomp
      end
      if count >= (@player_ships.count - 1)
        break
      end
      count += 1
    end
    puts @player.render(true)
    run
  end

  def display
    puts "=============COMPUTER BOARD============="
    puts @computer.render
    puts "==============PLAYER BOARD=============="
    puts@player.render(true)
  end

  def run
    while !@game_over
      display
      puts "Enter a valid coordinate for your shot:"
      player_shot = gets.chomp

      while (!computer.valid_coordinate?(player_shot) || computer.cells[player_shot].fired_upon?)
        puts "Not a valid coordinate. Please try again"
        player_shot = gets.chomp
      end
      computer.cells[player_shot].fire_upon

      sample_computer_shot = player.cells.keys.sample 
      sample_computer_shot = intelligent_shot.shift if !intelligent_shot.empty?  
      
      while player.cells[sample_computer_shot].fired_upon? 
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
        intelligent_shot.concat(player.adjacent_cells(sample_computer_shot))
      elsif player.cells[sample_computer_shot].render == 'X'
        puts "My shot on #{player.cells[sample_computer_shot].coordinate} sunk your #{player.cells[sample_computer_shot].ship.name}"
      end

      computer_ships = computer.cells.find_all { |cell, cell_object| !cell_object.empty? }
      player_ships = player.cells.find_all { |cell, cell_object| !cell_object.empty? }

      if (computer_ships.any? { |cell| cell[1].ship.sunk == false } && player_ships.any? {|cell| cell[1].ship.sunk == false})
        run
      elsif (computer_ships.all? { |cell| cell[1].ship.sunk == true } && player_ships.all? {|cell| cell[1].ship.sunk == true})
        puts "Tie Game!"
        @game_over = true
      elsif computer_ships.any? {|cell| cell[1].ship.sunk == false} == false 
        puts "Player Won!"
        @game_over = true
      else
        puts "Computer Won!"
        @game_over = true
      end
    end
    main_menu
  end
end