require './spec/spec_helper'

puts "Welcome to BATTLESHIP!" 
puts "Enter p to play. Enter q to quit."

input = gets.chomp

if input == "q"
  puts "See you later!"

elsif input == "p"
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