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
  end

end
