require 'digest/sha1'

class Player < ActiveRecord::Base
  attr_accessible :name, :rating, :password, :salt, :confirm_password

  attr_accessor :confirm_password

  has_many :matches

  K_FACTOR = 32
  MIN_RATING = 100

  validates :rating, :numericality => { :greater_than_or_equal_to => MIN_RATING }

  after_initialize :set_min_rating

  def set_min_rating
    self.rating ||= MIN_RATING
  end

  def salt
    self[:salt] ||= Digest::SHA1.hexdigest Time.now.to_s
  end

  def password=(raw_password)
    self[:password] = Player.hashed_password(raw_password, salt)
  end

  def self.salted_password(raw_password, salt)
    "#{raw_password}#{salt}"
  end

  def self.hashed_password(raw_password, salt)
    Digest::SHA1.hexdigest salted_password(raw_password, salt)
  end

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

  def self.authenticate(name, password)
    player = find_by_name name
    return player if player.password == hashed_password(password, player.salt)
  end
end
