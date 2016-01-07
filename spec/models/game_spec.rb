require 'rails_helper'

RSpec.describe Game, :type => :model do
  let(:user) { create(:user) }
  let(:game) { Game.create(:creator => user, :rounds => 2) }

  it 'includes the creator in the players list' do
    expect(game.users).to match_array [user]
  end

  it 'is single when no other user is playing' do
    expect(game).to be_single
  end

  it 'is not single when when played with more users' do
    game.players.create(:user => create(:user))
    game.save!

    expect(game).to_not be_single
  end

  describe '#answer!' do
    let(:trivia) { create(:trivia, :with_options) }

    subject do
      game.answer!(user, {
        :trivia_id => trivia.id,
        :option_id => trivia.correct_option_id
      })
    end

    it 'answers with the given user' do
      expect(subject.user).to eql user
    end

    it 'answers with the trivia and option' do
      expect(subject.trivia).to eql trivia
    end

    it 'answers with the trivia and option' do
      expect(subject.option).to eql trivia.correct_option
    end
  end

  describe '#has_rounds?(user)' do
    let(:trivia1) { create(:trivia, :with_options) }
    let(:trivia2) { create(:trivia, :with_options) }
    let(:trivia3) { create(:trivia, :with_options) }

    it 'has rounds when the number of answers is less than the number of rounds' do
      game.answer!(user, {:trivia => trivia1, :option => trivia1.correct_option})

      expect(game).to have_rounds(user)
    end

    it 'does not have rounds when the number of answers is equal to the number of rounds' do
      game.answer!(user, {:trivia => trivia1, :option => trivia1.correct_option})
      game.answer!(user, {:trivia => trivia2, :option => trivia2.correct_option})

      expect(game).to_not have_rounds(user)
    end

    it 'does not have rounds when the number of answers is over the number of rounds' do
      game.answer!(user, {:trivia => trivia1, :option => trivia1.correct_option})
      game.answer!(user, {:trivia => trivia2, :option => trivia2.correct_option})
      game.answer!(user, {:trivia => trivia2, :option => trivia3.correct_option})

      expect(game).to_not have_rounds(user)
    end
  end
end
