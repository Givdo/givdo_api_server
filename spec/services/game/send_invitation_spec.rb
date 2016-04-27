require 'rails_helper'

RSpec.describe Game::SendInvitation do
  subject(:service) { described_class }

  it "creates a GCM notification" do
    user = build(:user)
    game = build(:game)

    expect(Rpush::Gcm::Notification).to receive(:create!)

    service.call(user, game)
  end
end
