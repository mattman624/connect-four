require 'spec_helper.rb'
#want yaml dump and undump
describe "Game object" do

  let(:game) { Game.new }

  before :each do
   
  end

  describe '#new' do
    it 'returns object class game' do
      expect(game.class).to eq(Game)
    end
  end
end

describe
