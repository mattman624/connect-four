require './board.rb'
require './player.rb'
require './game.rb'

class ConnectFour

  def initialize()
    show_menu
  end

  def show_menu
    user_input = ""

    until user_input == "q"
      puts "What would you like to do?
        1. Play 2 player game
        q. Quit"

      user_input = gets.chomp

      case user_input
      when "1" 
        player1 = new_player(1)
        player2 = new_player(2)
        game = Game.new(player1, player2)
      end
    end
  end

  def new_player(player_number)
    puts "What is player #{player_number}'s name?"
    name = gets.chomp.capitalize

    puts "What is #{name}'s prefered token?"
    mark = gets.chomp

    player = Player.new(name, mark)
  end
end





