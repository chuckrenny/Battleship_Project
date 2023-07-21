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

end