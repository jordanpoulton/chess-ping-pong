require 'test_helper'


class MatchesControllerTest < ActionController::TestCase

  test "can create a match" do
    player =Player.create(:name => "Jordan", :rating => 400)
    opponent = Player.create(:name => "Leo", :rating => 200)
    old_player_rating = player.rating
    player_wins = 4
    opponent_wins = 1
    # session[:player_id] = player.id
    params = {
      :match => {
        :player => player.id,
        :opponent => opponent.id
      },
      :player_wins => player_wins,
      :opponent_wins => opponent_wins
    }
    post :create, params, {:player_id => player.id}
    assert @controller.current_player?
    assert_equal((player_wins+opponent_wins), Match.count)
    assert_equal 4, Match.won.count
    assert_equal 1, Match.lost.count
    assert_not_equal(old_player_rating, player.reload.rating)
  end

  test "player cannot create match without being signed in" do
    player =Player.create(:name => "Jordan", :rating => 400)
    opponent = Player.create(:name => "Leo", :rating => 200)
    @current_player = 0
    params = {
      :match => {
        :player => player.id,
        :opponent => opponent.id
      },
      :player_wins => 1,
      :opponent_wins => 0
    }
    post :create, params
    assert_equal 0, Match.all.count
    assert_redirected_to root_path
  end

  test "player cannot create match where neither player is signed in" do
    player =Player.create(:name => "Jordan", :rating => 400)
    opponent = Player.create(:name => "Leo", :rating => 200)
    cheater = Player.create(:name => "Cheaty", :rating => 200)
    params = {
      :match => {
        :player => player.id,
        :opponent => opponent.id
      },
      :player_wins => 1,
      :opponent_wins => 0
    }
    post :create, params, {:player_id => cheater.id}
    assert_equal 0, Match.all.count
    assert_redirected_to root_path
  end
end
