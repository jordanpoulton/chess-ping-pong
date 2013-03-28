class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_player?
  #makes current_player? method availabe in the view for stuff like showing 'join' or 'login' depending on whether they are existing members

  def current_player?
    !!current_player
    #!! turns the object into a boolean
    #NB current_player is not a local variable. It's a call to the method current_player
  end

  def current_player
    @current_player ||= session[:player_id] && Player.find_by_id(session[:player_id])
    # if there is a session[:player_id] it will return the Player that we are looking up in the second half, if session[:id] is false, the whole expression will return false and @current_player will not be set
  end

  def check_logged_in
    redirect_to(new_session_path, :notice => "Login to do this") unless current_player?
    #Checks that current_player? returns true, otherwise redirects user to login
  end

end
