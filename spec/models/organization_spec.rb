require 'rails_helper'

RSpec.describe Organization, type: :model do
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
