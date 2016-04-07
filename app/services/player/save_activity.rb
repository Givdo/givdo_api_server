class Player::SaveActivity
  def self.call(player)
    new.call(player)
  end

  def call(player)
    return unless player.finished?

    Activity.create(
      user: player.user,
      subject: player,
      name: activity_name(player)
    )
  end

  private

  def activity_name(player)
    player.winner? ? 'won_scores' : 'lost_scores'
  end
end
