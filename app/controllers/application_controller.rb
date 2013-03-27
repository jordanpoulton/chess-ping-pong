class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_player?

  def current_player?
    !!current_player
  end

  def current_player
    @current_player ||= session[:player_id] && Player.find_by_id(session[:player_id])
  end

  def check_logged_in
    redirect_to(new_session_path, :notice => "Login to do this") unless current_player?
  end

end
