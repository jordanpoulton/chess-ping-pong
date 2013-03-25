require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "expected_score_should_autocalculate" do
    # create player_1 - rating 400
    # create player_2 - rating 200
    # expected score for player 1 should be 0.75 (if 200 point difference)
    player_1 = Player.create(:name => "Jordan", :rating => "400")
    player_2 = Player.create(:name => "Leo", :rating => "200")
    match = Match.create(:player_id => player_1.id, :opponent_id => player_2.id, :victory => true)
    assert_in_delta(0.75, match.player.expected_score(match.player.rating, match.opponent.rating), 0.01)#(player_1_rating, player_2_rating)
  end

  test "expected_score_should_autocalculate_loser" do
    # create player_1 - rating 400
    # create player_2 - rating 200
    # expected score for player 1 should be 0.75 (if 200 point difference)
    player_1 = Player.create(:name => "Jordan", :rating => "400")
    player_2 = Player.create(:name => "Leo", :rating => "200")
    match = Match.create(:player_id => player_2.id, :opponent_id => player_1.id, :victory => true)
    assert_in_delta(0.24, match.player.expected_score(match.player.rating, match.opponent.rating), 0.01)#(player_2_rating, player_1_rating)
  end

  test "new rating calculates correctly" do
# new rating = old rating + Knumber((actual score - expected score)
    player_1 = Player.create(:name => "Jordan", :rating => "1613")
    player_2 = Player.create(:name => "Leo", :rating => "1413")
    match = Match.create(:player_id => player_1.id, :opponent_id => player_2.id, :victory => true)
  assert_in_delta(1620, player_1.update_rating!(match), 1)
  end

  test "rating cannot go below 100" do
    player_1 = Player.create(:name => "Jordan", :rating => "100")
    player_2 = Player.create(:name => "Leo", :rating => "150")
    match = Match.create(:player_id => player_1.id, :opponent_id => player_2.id, :victory => false)
    player_1.update_rating!(match)
    assert_equal(100, player_1.rating)
  end

end
