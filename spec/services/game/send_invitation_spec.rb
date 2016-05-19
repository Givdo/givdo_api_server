require 'rails_helper'

RSpec.describe Game::SendInvitation do
  subject(:service) { described_class }

  context "when the user has devices" do
    it "creates a GCM notification" do
      user = build(:user, :with_device)
      game = build(:game)

      expect(Rpush::Gcm::Notification).to receive(:create!)

      service.call(user, game)
    end
  end

  context "when the user don't has devices" do
    it "doesn't creates a GCM notification" do
      user = build(:user, devices: [])
      game = build(:game)

      expect(Rpush::Gcm::Notification).not_to receive(:create!)

      service.call(user, game)
    end
  end
end
