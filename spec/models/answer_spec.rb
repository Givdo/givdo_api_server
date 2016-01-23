require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'answer correction' do
    let(:trivia) { create(:trivia, :with_options) }

    it 'sets answer as correction when the option is the one marked as correct' do
      correct_answer = create(:answer, :trivia => trivia, :trivia_option => trivia.correct_option)

      expect(correct_answer).to be_correct
    end

    it 'sets answer as correction when the option is the one marked as correct' do
      wrong_answer = create(:answer, :trivia => trivia, :trivia_option_id => trivia.options.last.id)

      expect(wrong_answer).to_not be_correct
    end
  end
end
