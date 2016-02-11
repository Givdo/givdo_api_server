require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:trivia) { create(:trivia, :with_options) }
  let(:player) { create(:player) }
  let(:correct_answer) { create(:answer, :player => player, :trivia => trivia, :trivia_option => trivia.correct_option) }
  let(:wrong_answer) { create(:answer, :player => player, :trivia => trivia, :trivia_option_id => trivia.options.last.id) }

  describe 'answer correction' do
    it 'sets answer as correction when the option is the one marked as correct' do
      expect(correct_answer).to be_correct
    end

    it 'sets answer as correction when the option is the one marked as correct' do
      expect(wrong_answer).to_not be_correct
    end
  end

  describe 'correct answers cache' do
    it 'updates the player score when the answer is correct' do
      expect { correct_answer }.to change { player.score }.by(1)
    end

    it 'does not update the player score when the answer is not correct' do
      expect { wrong_answer }.to_not change(player, :score)
    end
  end
end
