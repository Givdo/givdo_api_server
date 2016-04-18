require 'rails_helper'

RSpec.describe Badge, type: :model do
  describe ".next_badges_for" do
    context "when user has enough score to next badge" do
      it "returns all corresponding badges" do
        badge_giver = create(:badge_giver)
        badge_giver_1 = create(:badge_giver_1)
        user = create(:user_with_finished_player, player_score: 100)

        badges = described_class.next_badges_for(user)

        expect(badges.size).to eq(1)
        expect(badges).to include(badge_giver)
      end
    end

    context "when user doesn't have enough score to next badge" do
      it "returns zero badges" do
        user = create(:user_with_finished_player)

        badges = described_class.next_badges_for(user)

        expect(badges).to be_empty
      end
    end
  end
end
