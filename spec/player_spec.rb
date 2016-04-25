require 'spec_helper.rb'

describe 'Player object' do
  let(:mark) {"X"}
  let(:name) {"Matt"}
  let(:player) {Player.new(name, mark)}
  let(:board) {Board.new}

  describe '#name' do
    it 'returns the name of the player' do
      expect(player.name).to eq(name)
    end
  end

  describe '#place_marker' do
    

end
