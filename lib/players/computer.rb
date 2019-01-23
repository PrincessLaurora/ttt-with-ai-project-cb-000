module Players
  class Computer < Player

    def move(board)
      move = nil
      #if computer is X start taking 5, if it's O and 5 is not taken, take 5:
      if !board.taken?(5)
      move = "5"
      #if 5 is taken and computer is O, move to 1:
      elsif board.turn_count == 1
      move = "1"
      #if computer is X and O takes 1, move to 9:
      elsif board.turn_count == 2 && board.taken?(1)
      move = "9"
      #if computer is X and O takes 3, move to 7:
      elsif board.turn_count == 2 && board.taken?(3)
      move = "7"
      #if computer is X and O takes 7, move to 3:
      elsif board.turn_count == 2 && board.taken?(7)
      move = "3"
      #if computer is X and O takes 9, move to 1:
      elsif board.turn_count == 2 && board.taken?(9)
      move = "1"
      #if computer is O and started from 5, if X is in the opposite corners, move to 2.
      elsif board.turn_count == 3 && (board.position(1) == board.position(9) || board.position(3) == board.position(7))
      move = "2"
      #now try to win by completing the winning combination (if you have 2 out of 3 positions taken of the combo) or block the winning chance of the opponent:
      else
        Game::WIN_COMBINATIONS.detect do |combo|
          if combo.select{|index| board.position(index+1) == token}.size == 2 && combo.any?{|index| board.position(index+1) == " "}
          move = combo.select{|index| !board.taken?(index+1)}.first.to_i.+(1).to_s
          elsif combo.select{|index| board.position(index+1) != " " && board.position(index+1) != token}.size == 2 && combo.any?{|index| board.position(index+1) == " "}
          move = combo.select{|index| !board.taken?(index+1)}.first.to_i.+(1).to_s
          end
        end
      #if there is no winning combo available, move to a corner as first choice or if it's not possible, move to an edge position:
        move = [1, 3, 7, 9, 2, 4, 6, 8].detect{|i| !board.taken?(i)}.to_s if move == nil
      #or move = rand(1..9).to_s
        end
        move
      end
    end

end

#corner = ["1", "3", "7", "9"]
#edge = ["2", "4", "6", "8"]

#def winning_chance
  #combo.select{|index| board.position(index+1) == token}.size == 2 && combo.any?{|index| board.position(index+1) == " "}
#end

#def winning_move
  #combo.select{|index| !board.taken?(index+1)}.first.to_i.+(1).to_s
#end

#def block_chance
    #combo.select{|index| board.position(index+1) != " " && board.position(index+1) != token}.size == 2 && combo.any?{|index| board.position(index+1) == " "}
#end

#def block_move
  #combo.select{|index| !board.taken?(index+1)}.first.to_i.+(1).to_s
#end
