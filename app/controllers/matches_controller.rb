class MatchesController < ApplicationController

  def new
    @match = Match.new
    @players = Player.limit(10).sort {|a,b| b.rating<=>a.rating}
  end

  def index
    @matches = Match.all
  end

  def create
    player_wins   = params[:player_wins].to_i
    opponent_wins = params[:opponent_wins].to_i
    multiplier =  player_wins + opponent_wins
    multiplier.times do |loop|
      match = Match.new
      match.player = Player.find(params[:match][:player])
      match.opponent = Player.find(params[:match][:opponent])
      (loop < player_wins) ? match.win! : match.lose!
      match.player.update_rating!(match)
      match.opponent.update_rating!(match)
      match.save!
    end
    redirect_to root_path
  end

end
