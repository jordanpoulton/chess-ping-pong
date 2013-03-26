class PlayersController < ApplicationController

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(params[:player])
    @player.rating = 100
    @player.save
    redirect_to players_path
  end

  def index
    @players = Player.limit(10).sort {|a,b| b.rating<=>a.rating}
    # @player = Player.new
    @match = Match.new
  end

  def world_ranking
    @players = Player.all.sort {|a,b| b.rating<=>a.rating}
    @player = Player.new
    @match = Match.new
  end

end
