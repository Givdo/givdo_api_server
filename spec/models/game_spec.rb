require 'rails_helper'

RSpec.describe Game, :type => :model do
  it 'includes the creator in the players list' do
    user = create(:user)
    game = Game.create(creator: user)

    expect(game.users).to match_array [user]
  end
end
