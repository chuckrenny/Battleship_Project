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


end
