require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe '.with_score' do
    it 'calculates the total score for each organization' do
      org = create(:organization_with_score, score: 10)

      organizations = Organization.with_score

      expect(organizations).to include org
      expect(organizations.first.total_score).to eq 10
    end
  end

  describe ".scores_between" do
    it "calculates scores for players created between the date range" do
      organization = nil
      
      Timecop.travel(1.day.ago) do
        organization = create(:organization_with_score, score: 10)
      end

      organizations = described_class.scores_between(2.day.ago, Time.current)

      expect(organizations).to include(organization)
      expect(organizations.first.total_score).to eq(10)
    end
  end

  describe '#cache!' do
    it 'stamps the cached time' do
      Timecop.freeze(now = Time.current)

      subject.cache!

      expect(subject.cached_at).to eql now
    end
  end

  describe "#cached?" do
    it 'is cached when the cached_at column is not nil' do
      subject.cached_at = DateTime.now

      expect(subject).to be_cached
    end

    it 'is not cached when the cached_at column is nil' do
      subject.cached_at = nil

      expect(subject).to_not be_cached
    end
  end
end
