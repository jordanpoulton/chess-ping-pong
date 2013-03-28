require 'digest/sha1'

class PlayersController < ApplicationController

  def new
    @player = Player.new #Player object for user to create their profile
  end

  def create
    @player = Player.new(params[:player])

    if @player.save
      sign_in!(@player)
      redirect_to root_path, :notice => "Welcome #{@player.name}!! Your current rating is #{@player.rating} - improve it."
    else
      redirect_to new_player_path, :notice => "There was a problem saving"
    end

  end

  def world_ranking
    @player = Player.new
    @match = Match.new
  end

  private

  def sign_in!(player)
    session[:player_id] = player.id
    current_player
    #Set session id and current_player to the player's id and they are signed in.
  end

end
