require 'spec_helper'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  describe "#initialize" do 
    it 'can instantiate a new @board with readable cells' do
      expect(@board).to be_a(Board)
      expect(@board.cells.values.first).to be_an(Cell)
      expect(@board.cells).to be_a(Hash)
      expect(@board.cells.keys.count).to eq(16)
    end
  end

  describe "#valid_coordinate?" do
    it 'can tell us if the coordinate is within bounds of the @board' do
      expect(@board.valid_coordinate?("A1")).to eq(true)
      expect(@board.valid_coordinate?("D4")).to eq(true)
      expect(@board.valid_coordinate?("A5")).to eq(false)
      expect(@board.valid_coordinate?("E1")).to eq(false)
      expect(@board.valid_coordinate?("A22")).to eq(false)
      expect(@board.valid_coordinate?("A5")).to eq(false)
    end
  end

  describe "#valid_placement?" do
    it 'checks numbers of coordinates in array equal to board length' do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to eq(false)
    end

    it 'checks for consecutive coordinates in array' do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to eq(false)
      expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to eq(false)
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A3"])).to eq(true)

      expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to eq(false)
    end

    it 'determines diagonal coordinates are invalid' do
      expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to eq(false)
    end

    it 'verifies valid placements' do
      expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to eq(true)
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to eq(true)
    end
  end
  
  describe "#helper_placement" do
    it 'is the helper method for #valid_placement?' do
      expect(@board.helper_placement(["A1", "A2", "A22"])).to be_a(FalseClass)
      expect(@board.helper_placement(["A1", "A2", "A3"])).to eq(true)
      expect(@board.helper_placement(["A1", "B1"])).to eq(true)
    end
  end

  describe "#place" do
    it 'can place a ship on the board' do
      @board.place(@cruiser, ["A1", "A2", "A3"])    
      cell_1 = @board.cells["A1"]
      cell_2 = @board.cells["A2"]
      cell_3 = @board.cells["A3"]

      expect(cell_1.ship).to eq(@cruiser)
      expect(cell_2.ship).to eq(@cruiser)
      expect(cell_3.ship).to eq(@cruiser)

      expect(cell_3.ship).to eq(cell_2.ship)
      expect(cell_3.ship == cell_2.ship).to eq(true)
    end

    it 'checks overlapping ship placements in the cells' do
      @board.place(@cruiser, ["A1", "A2", "A3"]) 
      expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to eq(false)
    end
  end
end

# The board should be able to place a ship in its cells. 
# Because a Ship occupies more than one cell, multiple Cells 
# will contain the same ship.