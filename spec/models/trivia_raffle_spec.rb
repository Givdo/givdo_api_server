require 'rails_helper'

describe TriviaRaffle do
  let(:game) { create(:game) }
  let(:user) { create(:user) }
  subject { TriviaRaffle.new(user) }

  describe ".next" do
    it 'is the next trivia not yet answered by the user in the last hour' do
      trivia1 = create(:trivia, :with_options)
      trivia2 = create(:trivia, :with_options)

      game.answer!(user, {
        :updated_at => 2.hours.ago,
        :trivia_id => trivia1.id,
        :option_id => trivia1.correct_option_id
      })
      game.answer!(user, {
        :updated_at => 30.minutes.ago,
        :trivia_id => trivia2.id,
        :option_id => trivia2.correct_option_id
      })

      expect(subject.next).to eql trivia1
    end
  end
end
