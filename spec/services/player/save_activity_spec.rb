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

      expect(Activity).to receive(:create).with(
        user: player.user, subject: player, name: 'lost_scores'
      )

      service.call(player)
    end

    context "when the player is a loser" do
      it "sets activity's name to lost_scores" do
        player = build(:player, finished_at: Time.current)

        allow(player).to receive(:winner?).and_return(false)

        expect(Activity).to receive(:create).with(
          user: player.user, subject: player, name: 'lost_scores'
        )

        service.call(player)
      end
    end

    context "when the player is a winner" do
      it "sets activity's name to won_scores" do
        player = build(:player, finished_at: Time.current)

        allow(player).to receive(:winner?).and_return(true)

        expect(Activity).to receive(:create).with(
          user: player.user, subject: player, name: 'won_scores'
        )

        service.call(player)
      end
    end
  end
end
