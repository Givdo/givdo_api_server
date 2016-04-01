require 'rails_helper'

RSpec.describe Cycle::CreateScores do
  subject(:service) { described_class }

  it "does nothing if the cycle isn't stoped" do
    cycle = create(:cycle, ended_at: nil)

    described_class.call(cycle)

    expect(cycle.scores).to be_empty
  end

  it "calculates scores for the cycle's period" do
    organization_a = create(:organization)
    organization_b = create(:organization)
    cycle = create(:cycle, created_at: 1.month.ago, ended_at: Time.current)

    Timecop.travel(cycle.created_at - 2.days) do
      create(:finished_player, organization: organization_a, score: 1)
      create(:finished_player, organization: organization_b, score: 2)
    end

    Timecop.travel(cycle.created_at + 2.days) do
      create(:finished_player, organization: organization_a, score: 3)
      create(:finished_player, organization: organization_b, score: 4)
    end

    described_class.call(cycle)

    expect(cycle.scores.map(&:score)).to include(3, 4)
  end
end
