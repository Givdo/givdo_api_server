require 'rails_helper'

describe TriviaRaffle do
  let(:user) { create(:user) }
  let(:another_game) { create(:game, :creator => user) }
  let(:game) { create(:game, :creator => user, :rounds => 2) }
  subject { TriviaRaffle.new(game.players.first) }

  describe ".next" do
    let!(:trivia1) { create(:trivia, :with_options) }
    let!(:trivia2) { create(:trivia, :with_options) }

    it 'is a trivia not responded by the user in the game context' do
      game.answer!(user, {
        :trivia => trivia1,
        :trivia_option => trivia1.correct_option
      })
      another_game.answer!(user, {
        :trivia => trivia2,
        :trivia_option => trivia2.correct_option
      })

      expect(subject.next).to eql trivia2
    end

    it 'is nil when no more trivias are available for the user in that game' do
      game.answer!(user, {:trivia => trivia1, :trivia_option => trivia1.correct_option})
      game.answer!(user, {:trivia => trivia2, :trivia_option => trivia2.correct_option})

      expect(subject.next).to be_nil
    end
  end
end
