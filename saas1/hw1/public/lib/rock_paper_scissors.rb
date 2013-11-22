class RockPaperScissors

  # Exceptions this class can raise:
  class NoSuchStrategyError < StandardError ; end

  def self.winner(player1, player2)
    strategies = {'R' => 0, 'P' => 1, 'S' => 2}
    if strategies.include? player1[1] and strategies.include? player2[1]
       if (strategies[player1[1]] + 1) % 3 == strategies[player2[1]]
         return player2
       else 
         return player1
       end
    else
       raise RockPaperScissors::NoSuchStrategyError, "Strategy must be one of R,P,S"
    end
  end

  def self.tournament_winner(tournament)
    if tournament[0].kind_of?(String) and tournament[1].kind_of?(String)
      return tournament
    end
  
    if tournament[0].kind_of?(Array)
      tournament[0] = tournament_winner(tournament[0])
    end
  
    if tournament[1].kind_of?(Array)
      tournament[1] = tournament_winner(tournament[1])
    end

    return winner(tournament[0], tournament[1])
  end

end