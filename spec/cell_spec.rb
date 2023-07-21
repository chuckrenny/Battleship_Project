require 'spec_helper'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe "#initialize" do
    it 'can initialize cell class' do
      expect(@cell).to be_a(Cell)
    end

    it 'has readable attributes' do
      expect(@cell.coordinate).to eq("B4")
      expect(@cell.ship).to eq(nil)
    end
  end

  describe "#empty?" do
    it 'can be empty' do
      expect(@cell.empty?).to eq(true)
    end
  end

  describe "#place_ship" do
    it 'can place a ship in the cell' do
      @cell.place_ship(@cruiser)
      expect(@cell.ship).to eq(@cruiser)

      expect(@cell.empty?).to eq(false)
    end
  end
end