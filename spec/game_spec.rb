require 'spec_helper.rb'

describe 'Game object' do  
  #let(:player1) { Player.new("Matt", "X") }
  #let(:board) { Board.new }
  let(:player1) { Player.new("matt", "X") }
  let(:player2) { Player.new("Susan", "O") }
  let(:game) { Game.new(player1, player2) }
  
  

  describe '#switch_players' do
    context "with two players" do
      before { game.players = [player1, player2] }    

      it 'switches player positions in the player array' do        
        game.switch_players
        expect(game.players[0]).to eq(player2)
      end
    end
  end

end
