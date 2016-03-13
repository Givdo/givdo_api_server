class Match
  def self.current(*args)
    new(*args).current
  end

  def initialize(user, versus=nil)
    @user = user
    @versus = versus
  end

  def current
    scope.last || @user.owned_games.create do |game|
      game.add_player(@versus) if @versus
    end
  end

  private

  def scope
    @scope ||= @user.games.unfinished.scoping do
      @versus ? Game.versus(@versus) : Game.single
    end
  end
end
