class SnackAndLeader
  LEADER = {"7" => "27", "21" => "78", "34" => "67", "62" => "93"}
  SNACK = {"29" => "6", "36" => "17", "47" => "23", "74" => "28", "97" => "9"}

  def play_game
    player1_moves = 1
    player2_moves = 0
    player1 = 0
    player2 = 0
    while(player1 < 100 && player2 < 100)
      if player1_moves
        dice = throw_dice
        if LEADER[(dice+player1).to_s]
          player1 = (LEADER[(dice+player1).to_s]).to_i
        elsif SNACK[(dice+player1).to_s]
          player1 = (SNACK[(dice+player1).to_s]).to_i
        else
          player1 += dice
        end
        puts "player1 current step #{player1}"
        player1_moves=0
        player2_moves=1
      end

      if(player1 >= 100)
        puts "Player 1 is winner"
        break
       end

      if player2_moves
        dice = throw_dice
        if LEADER[(dice+player2).to_s]
          player2 = (LEADER[(dice+player2).to_s]).to_i
        elsif SNACK[(dice+player2).to_s]
          player2 = (SNACK[(dice+player2).to_s]).to_i
        else
          player2 += dice
        end
        puts "player2 current step #{player2}"
        player1_moves = 1
        player2_moves = 0
      end

      if(player2 >= 100)
        puts "Player 2 is winner"
        break
      end
    end 
  end

  def throw_dice
    dice = rand(1..6)
  end
end

obj = SnackAndLeader.new

obj.play_game