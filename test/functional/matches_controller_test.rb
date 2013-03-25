require 'test_helper'
require 'player'

class MatchesControllerTest < ActionController::TestCase

  test "can create a match" do
    player =Player.create(:name => "Jordan", :rating => 400)
    opponent = Player.create(:name => "Leo", :rating => 200)
    old_player_rating = player.rating
    player_wins = 4
    opponent_wins = 1
    params = {
      :match => {
        :player => player.id,
        :opponent => opponent.id
      },
      :player_wins => player_wins,
      :opponent_wins => opponent_wins
    }
    post :create, params
    assert_equal((player_wins+opponent_wins), Match.count)
    assert_equal 4, Match.won.count
    assert_equal 1, Match.lost.count
    assert_not_equal(old_player_rating, player.reload.rating)
  end
end
