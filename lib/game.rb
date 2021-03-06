class Game

  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,4,8],
    [2,4,6],
    [0,3,6],
    [1,4,7],
    [2,5,8],
  ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def current_player
    if board.turn_count.even?
      player_1
    else
      player_2
    end
  end

  def won?
      WIN_COMBINATIONS.detect do |combination|
      board.cells[combination[0]] == board.cells[combination[1]] &&
      board.cells[combination[1]] == board.cells[combination[2]] &&
      board.taken?(combination[0]+1)
      end
    end

    def draw?
      !won? && board.full?
    end

    def over?
       won? || draw?
    end

    def winner
      if win_combo = won?
      winner = board.cells[win_combo.first]
      end
    end

    def turn
        player = current_player
        move = player.move(board)
        if !board.valid_move?(move)
          turn
        else
          puts "Turn: #{@board.turn_count+1}\n * * * * * *"
          board.update(move, player)
          board.display
          puts "\n * * * * * *"
        end
    end

    def play
      while !over?
        turn
      end
      if won?
        puts "Congratulations #{winner}!"
      elsif draw?
        puts "Cat's Game!"
      end
    end

    def play_again?
      while !over?
        turn
      end
        if won?
          puts "Congratulations #{winner}!"
        elsif draw?
          puts "Cat's Game!"
        end
          puts "Would you like to play again?(y/n)"
            input = gets.strip
          if input == "y"
            puts "OK, let's go!"
            board.reset!
            play_again?
          elsif
            input == "n"
            puts "See you next time!"
          end
      end

end
