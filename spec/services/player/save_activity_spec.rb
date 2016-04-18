require 'rails_helper'

RSpec.describe Player::SaveActivity do
  subject(:service) { described_class }

  context "when player isn't finished" do
    it "doesn't create activity" do
      player = double(Player, finished?: false)

      expect(Activity).not_to receive(:create)

      service.call(player)
    end
  end

  context "when player is finished" do
    it "creates an activity" do
      player = build(:player, finished_at: Time.current)

      expect(player).to receive(:create_user_activity!)

      service.call(player)
    end
  end
end
