require 'spec_helper'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
  end

  describe "#initialize" do 
    it 'can instantiate a new board with readable cells' do
      expect(@board).to be_a(Board)
      expect(@board.cells.values.first).to be_an(Cell)
      expect(@board.cells).to be_a(Hash)
      expect(@board.cells.keys.count).to eq(16)
    end
  end
end
