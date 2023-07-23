require 'spec_helper'

RSpec.describe Setup do
  before(:each) do
    @start = Setup.new
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


end