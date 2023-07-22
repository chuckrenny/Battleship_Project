require 'spec_helper'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
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
end
