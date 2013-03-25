class PlayersController < ApplicationController

  def new
  end

  def create
    @player = Player.new(params[:player])
    @player.rating = 100
    @player.save
    redirect_to players_path
  end

  def index
    @players = Player.all
    @player = Player.new
    @match = Match.new
  end

end
