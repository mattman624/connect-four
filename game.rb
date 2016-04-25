
class Game
  attr_accessor :players

  def initialize(player1, player2)
    @players = [player1, player2]
    start_game
  end

  def switch_players
    @players[0], @players[1] = @players[1], @players[0]
  end

  def start_game
    @board = Board.new
    game_over = false

    until game_over == true
      
      space = player_turn      
      game_over = @board.check_win?(space[0], space[1])
      switch_players unless game_over
      
    end

    puts "Congrats #{@players[0].name}!"

    @board.show
  end

  def player_turn
    name = @players[0].name
    mark = @players[0].mark

    @board.show

    puts "Which column will #{name} place your token?"
    column = gets.chomp.to_i

    row = @board.set_piece(column, mark)

    while row == -1
      puts "Can't place in that column, please retry"
      column = gets.chomp.to_i
      row = @board.set_piece(column, mark)
    end
    [column, row]
  end
end
