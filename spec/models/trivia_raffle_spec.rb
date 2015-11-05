require 'rails_helper'

describe TriviaRaffle do
  let(:user) { create(:user) }
  subject { TriviaRaffle.new(user) }

  describe ".next" do
    it 'is the next trivia not yet answered by the user in the last hour' do
      trivia1 = create(:trivia, :with_options)
      trivia2 = create(:trivia, :with_options)

      trivia1.answer!(user, trivia1.options.first.id).update_attribute(:updated_at, 2.hours.ago)
      trivia2.answer!(user, trivia2.options.first.id).update_attribute(:updated_at, 30.minutes.ago)

      expect(subject.next).to eql trivia1
    end
  end
end
