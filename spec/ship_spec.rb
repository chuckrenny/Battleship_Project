require 'spec_helper'

RSpec.describe Ship do
  before(:each) do
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe "Initialize Method and Access Attributes" do
    it 'can initialize Ship class' do
      expect(@cruiser).to be_an(Ship)
    end

    it 'can access ship attributes' do
      expect(@cruiser.name).to eq("Cruiser")
      expect(@cruiser.length).to eq(3)
      expect(@cruiser.health).to eq(3)
    end
  end

  describe "#sunk?" do
    it 'returns false if the ship is not sunk' do
      expect(@cruiser.sunk?).to eq(false)
    end

    it 'returns true if health is zero' do
      @cruiser.hit
      @cruiser.hit
      @cruiser.hit
      @cruiser.hit
      expect(@cruiser.health).to eq(0)
      expect(@cruiser.sunk?).to eq(true)
    end
  end

  describe "#hit" do
    it 'can reduce ship health' do
      expect(@cruiser.health).to eq(3)
      @cruiser.hit
      expect(@cruiser.health).to eq(2)
    end

    it 'can not reduce ship health below zero' do
      @cruiser.hit
      @cruiser.hit
      @cruiser.hit
      @cruiser.hit
      expect(@cruiser.health).to eq(0)
    end
  end


end
