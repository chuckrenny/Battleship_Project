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

  describe "#fired_upon?" do
    it 'defaults to false on creation' do
      expect(@cell.fired_upon?).to eq(false)
    end

    it 'returns true after having been fired upon' do
      @cell.fire_upon
      expect(@cell.fired_upon?).to eq(true)
    end
  end

  describe "#fire_upon" do
    it 'reduces ship health when fired upon' do
      @cell.place_ship(@cruiser)
      expect(@cell.ship.health).to eq(3)
      @cell.fire_upon
      expect(@cell.ship.health).to eq(2)
    end

    it 'can only fire upon a cell once' do
      @cell.place_ship(@cruiser)
      @cell.fire_upon
      expect(@cell.ship.health).to eq(2)

      expect(@cell.fire_upon).to eq("Already fired upon this cell.")
      expect(@cell.ship.health).to eq(2)
    end
  end

  describe "#render" do
    let(:cell_1)    {Cell.new("B4")}
    let(:cell_2)    {Cell.new("C3")}

    it 'can display the state of the cell' do
      expect(cell_1.render).to eq(".")
    end

    it 'can display ship location if desired' do
      cell_1.place_ship(@cruiser)
      expect(cell_1.render).to eq(".")
      expect(cell_1.render(true)).to eq("S")

      expect(cell_2.render(true)).to eq(".")
    end

    it 'can display a missed shot' do
      cell_1.fire_upon
      expect(cell_1.render).to eq("M")
    end
    
    it 'can display a hit shot on a ship' do
      cell_2.place_ship(@cruiser)

      cell_2.fire_upon
      expect(cell_2.render).to eq("H")
      expect(cell_2.ship.health).to eq(2)
    end

    it 'can display a sunk ship' do
      cell_2.place_ship(@cruiser)
      expect(cell_2.ship.health).to eq(3)

      @cruiser.hit
      @cruiser.hit
      expect(cell_2.ship.health).to eq(1)

      cell_2.fire_upon
      expect(cell_2.ship.health).to eq(0)
      expect(@cruiser.sunk?).to eq(true)
      expect(cell_2.render).to eq("X")
    end
  end
end