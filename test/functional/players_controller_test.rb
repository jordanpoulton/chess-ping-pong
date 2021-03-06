require 'test_helper'
require 'player'

class PlayersControllerTest < ActionController::TestCase

  test "player can sign up" do
    post :create, {:player => {:name => "Testy_McTesterton", :password => "test", :password_confirmation => "test"}}
    assert_redirected_to root_url
    assert Player.count ==1
  end

  test "passwords must match to save" do
    post :create, {:player => {:name => "Testy_McTesterton", :password => "test", :password_confirmation => "wrong"}}
    assert_redirected_to new_player_path
  end

  test "passwords are salted and hashed" do
    post :create, {:player => {:name => "Testy_McTesterton", :password => "test", :password_confirmation => "test"}}
    assert_not_equal(Player.first.password, "test")
    assert_redirected_to root_url
  end

  test "Signing up creates a session" do
    post :create, {:player => {:name => "Testy_McTesterton", :password => "test", :password_confirmation => "test"}}
    assert_equal Player.first.id, session[:player_id]
  end


end
