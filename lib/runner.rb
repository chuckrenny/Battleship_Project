require './spec/spec_helper'

puts "Welcome to BATTLESHIP!" 
puts "Enter p to play. Enter q to quit."

input = gets.chomp

if input == "q"
  puts "See you later!"
  
elsif input == "p"
  puts "Let's Play!"
  setup = Setup.new
  setup.computer_placement
  puts "I have laid out my ships on the grid. \n" +
        "You now need to lay out your ships \n" +
        "The Cruiser is three units long and the Submarine is two unit long"
  puts setup.player.render
  puts " Enter the squares for the Cruiser (3 spaces):  \n" +
       " Example: A1, A2, A3"
  cruiser_placement = gets.chomp
  cruiser = Ship.new("Cruiser", 3)

  if setup.player_placement(cruiser, cruiser_placement)
    puts setup.player.render(true)
  end

  puts " Enter the squares for the Submarine (2 spaces):  \n" +
       " Example: B1, C1"
  submarine_placement = gets.chomp
  submarine = Ship.new("Submarine", 2)

  if setup.player_placement(submarine, submarine_placement)
    puts setup.player.render(true)
  end
end