class MatchesController < ApplicationController

  def new
    @match = Match.new #Creates a match object for the user to add their info to
  end

  def create
    (params[:player_wins].to_i + params[:opponent_wins].to_i).times do |loop|
      match = Match.new
      match.player = Player.find(params[:match][:player])
      @player_old_rating = match.player.rating
      match.opponent = Player.find(params[:match][:opponent])
      @opponent_old_rating = match.opponent.rating
      (loop < params[:player_wins].to_i) ? match.win! : match.lose!
      match.player.update_rating!(match)
      match.opponent.update_rating!(match)
      match.save!
      #1: add tota number of matches & iterate that many times
      #2, create a match and assign one to player and the other to opponent
      # while on the loops that belong to player, player won (match.win), for all the rest, opponent won (match.lose)
      #Update player and opponent ranking according to the match created on this iteration of the loop
      #save
    end
    redirect_to root_path, :notice => "#{Player.find(params[:match][:player]).name} went from #{@player_old_rating} to rating #{Player.find(params[:match][:player]).rating} --- #{Player.find(params[:match][:opponent]).name} went from #{@opponent_old_rating} to rating #{Player.find(params[:match][:opponent]).rating}, "
  end

end
