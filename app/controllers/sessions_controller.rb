class SessionsController < ApplicationController
  def new
  end

  def create
    if player = Player.authenticate(params[:name], params[:password])
      session[:player_id] = player.id
      current_player
      redirect_to root_path
    else
      flash[:notice] = "Failed to login"
      redirect_to new_session_path
    end
  end

  def destroy
    @current_player = session[:player_id] = nil
    redirect_to root_path
  end
end