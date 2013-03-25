require 'test_helper'

class MatchTest < ActiveSupport::TestCase

  test "match can be won" do
    match = Match.new
    refute match.won?
    match.win!
    assert match.won?
  end

  test "match can be lost" do
    match = Match.new
    match.win!
    assert match.won?
    match.lose!
    refute match.won?
  end

end
