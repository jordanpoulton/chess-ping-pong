require 'test_helper'
require 'player'

class SessionsControllerTest < ActionController::TestCase

  test "user can logout" do
    testy = Player.create!(:name => "Testy_McTesterton", :password => "test", :confirm_password => "test")
    session[:player_id] = testy.id
    assert_equal testy.id, session[:player_id]
    get :destroy
    refute session[:player_id]
    assert_redirected_to root_path
  end

  test "user can log in with correct details" do
    testy = Player.create!(:name => "Testy_McTesterton", :password => "test", :confirm_password => "test")
    post :create, {:name => "Testy_McTesterton", :password => "test"}
    assert_redirected_to root_path
    assert_equal testy.id, session[:player_id]
  end

end
