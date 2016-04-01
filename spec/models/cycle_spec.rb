require 'rails_helper'

RSpec.describe Cycle, type: :model do
  describe '#stop!' do
    it 'updates ended_at to now' do
      Timecop.freeze
      cycle = create(:cycle, ended_at: nil)

      cycle.stop!
      cycle.reload

      expect(cycle.ended_at).to eq(Time.current)
    end
  end

  describe ".score" do
    it 'sums only scores for this cycle' do
      cycle = create(:cycle, :with_score, scores: 5, cycle_score: 10)

      expect(cycle.score).to eq(50)
    end
  end
end
