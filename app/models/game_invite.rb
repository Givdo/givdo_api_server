class GameInvite
  def self.invite!(*args)
    new(*args).invite!
  end

  def initialize(inviter, provider, invitees)
    @inviter, @provider, @invitees = inviter, provider, invitees
  end

  def invite!
    game.tap(&:save!)
  end

  private

  def game
    @game ||= Game.new({
      :creator => @inviter,
      :players => [@inviter] + invitees_users
    })
  end

  def invitees_users
    User.for_provider_batch!(@provider, @invitees)
  end
end
