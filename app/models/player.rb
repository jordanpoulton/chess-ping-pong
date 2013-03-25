class Player < ActiveRecord::Base
  attr_accessible :name, :rating

  has_many :matches

  K_FACTOR = 32
  MIN_RATING = 100

  validates :rating, :numericality => { :greater_than_or_equal_to => MIN_RATING }

  def expected_score(player, opponent)
    1 / (1+ 10**((opponent-player)/400.00))
  end

  def update_rating!(match)
    real_score = self.won?(match) ? 1 : 0
    my_expected_score = self.expected_score(self.rating, match.opponent.rating)

    self.rating = [MIN_RATING, self.rating + (K_FACTOR*(real_score - my_expected_score))].max


  end

  def won?(match)
    (match.player == self && match.won?) || (match.opponent == self && match.lost?)

  end
end
