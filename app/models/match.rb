class Match < ActiveRecord::Base
  attr_accessible :opponent_id, :player_id, :victory

  belongs_to :player, :class_name => Player, :autosave => true
  belongs_to :opponent, :class_name => Player, :autosave => true

  scope :won, where(:victory => true)
  scope :lost, where(:victory => false)

  def won?
    victory
  end

  def lost?
    !won?
  end

  def win!
    self.victory = true
  end

  def lose!
    self.victory = false
  end

end
