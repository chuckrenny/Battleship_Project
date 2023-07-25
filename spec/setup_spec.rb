require 'spec_helper'

RSpec.describe Setup do
  before(:each) do
    @start = Setup.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  describe "#initialize" do
    it 'creates the start of a new game' do
      expect(@start).to be_a Setup
    end

    it 'has 2 boards to begin, a computer and a player' do
      expect(@start.computer).to be_a Board
      expect(@start.player).to be_a Board
    end
  end

  describe "#computer_placement" do
    it 'will place cruiser and submarine ships on to the board' do
      cruiser = Ship.new("Cruiser", 3)
      @start.computer_placement(cruiser)

      array_cell_object = @start.computer.cells.values
      expect(array_cell_object.any? { |cell| !cell.empty?}).to eq(true)
    end
  end

  describe "#player_placement" do
    it 'places a ship on the player board' do
      @start.player_placement(@cruiser, "A1 A2 A3")
      board_projection_player = 
      ("  1 2 3 4 \n" +
      "A S S S . \n" +
      "B . . . . \n" +
      "C . . . . \n" +
      "D . . . . \n")

      expect(@start.player.render(true)).to eq(board_projection_player)
    end
  end

  describe "#turn" do
    before(:each) do
      @start.computer_placement(@cruiser)
      @start.computer_placement(@submarine)
      @start.player_placement(@cruiser, "A1, A2, A3")
      @start.player_placement(@submarine, "B1, C1")
    end

    it 'will display the boards of both sides' do
      board_projection_computer = 
      ("  1 2 3 4 \n" +
      "A . . . . \n" +
      "B . . . . \n" +
      "C . . . . \n" +
      "D . . . . \n")

      board_projection_player = 
      ("  1 2 3 4 \n" +
      "A S S S . \n" +
      "B S . . . \n" +
      "C S . . . \n" +
      "D . . . . \n")
      
      expect(@start.computer.render).to eq(board_projection_computer)
      expect(@start.player.render(true)).to eq(board_projection_player)
    end
  end
end