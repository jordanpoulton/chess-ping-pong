class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:password].blank?
      redirect_to root_path,
      :notice => "Password can't be empty"
      return
    end

    if player = Player.authenticate(params[:name], params[:password])

      session[:player_id] = player.id
      current_player

      flash[:notice] = "Welcome to the party #{player.name}. Your current rating is #{player.rating}"
      redirect_to root_path
    else
      flash[:notice] = "Failed to login"
      redirect_to root_path
    end
  end

  def destroy
    @current_player = session[:player_id] = nil
    redirect_to root_path, :notice => "You've been logged out. Smell ya later"
  end
end
