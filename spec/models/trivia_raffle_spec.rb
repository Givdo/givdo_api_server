require 'rails_helper'

describe TriviaRaffle do
  let(:another_game) { create(:game) }
  let(:game) { create(:game, :rounds => 2) }
  let(:user) { create(:user) }
  subject { TriviaRaffle.new(user, game) }

  describe ".next" do
    let!(:trivia1) { create(:trivia, :with_options) }
    let!(:trivia2) { create(:trivia, :with_options) }

    it 'is a trivia not responded by the user in the game context' do
      game.answer!(user, {
        :trivia => trivia1,
        :option => trivia1.correct_option
      })
      another_game.answer!(user, {
        :trivia => trivia2,
        :option => trivia2.correct_option
      })

      expect(subject.next).to eql trivia2
    end

    it 'is nil when no more trivias are available for the user in that game' do
      game.answer!(user, {:trivia => trivia1, :option => trivia1.correct_option})
      game.answer!(user, {:trivia => trivia2, :option => trivia2.correct_option})

      expect(subject.next).to be_nil
    end
  end
end
