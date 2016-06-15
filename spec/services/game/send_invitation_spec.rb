require 'rails_helper'

RSpec.describe Game::SendInvitation do
  subject(:service) { described_class }

  it "creates a new notification for the user" do
    user = build(:user)
    game_owner = build(:user)
    game = build(:game, creator: game_owner)

    expect(Notification).to receive(:create!).with(game: game, user: user, sender: game_owner)

    service.call(user, game)
  end
end
