class GameInvite
  def self.invite!(*args)
    new(*args).invite!
  end

  def initialize(game, provider, invitees)
    @game, @provider, @invitees = game, provider, invitees
  end

  def invite!
    User.for_provider_batch!(@provider, @invitees).each do |user|
      @game.players.build(:user => user)
    end
    @game.tap(&:save!)
  end
end
