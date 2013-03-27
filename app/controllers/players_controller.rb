require 'digest/sha1'

class PlayersController < ApplicationController

  def new
    @player = Player.new
    @players = Player.limit(10).sort {|a,b| b.rating<=>a.rating}
  end

  def create
    @player = Player.new
    unless params[:player][:password] == params[:player][:confirm_password]
      render :new, :notice => "Passwords must match"
      return
    end
    @player.name = params[:player][:name]
    @player.password = params[:player][:password]
    if @player.save
      sign_in!(@player)
      redirect_to root_path
    else
      render :new, :notice => "There was a problem saving"
    end
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

  def sign_in!(player)
    session[:player_id] = player.id
    current_player
  end

end
