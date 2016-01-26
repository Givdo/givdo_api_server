require 'rails_helper'

RSpec.describe Game, :type => :model do
  let(:trivia) { create(:trivia, :with_options) }
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

  describe '#player' do
    it 'is the player of the user in the game' do
      another_user = create(:user)
      player = game.players.create(:user => another_user)

      expect(game.player(another_user)).to eql player
    end

    it 'is nil if the user has no player in the game' do
      user = create(:user)
      game.players.where(:user => user).destroy_all

      expect(game.player(user)).to be_nil
    end
  end

  describe '#unfinished?' do
    it 'is unfinished when every round for every player was played' do
      game.update_attribute(:rounds, 1)
      game.answer!(user, {
        :trivia_id => trivia.id,
        :trivia_option_id => trivia.correct_option_id
      })

      expect(game).to_not be_unfinished
    end

    it 'is not unfinished when any player still have rounds left' do
      game.update_attribute(:rounds, 1)
      game.players.create(:user => create(:user))
      game.answer!(user, {
        :trivia_id => trivia.id,
        :trivia_option_id => trivia.correct_option_id
      })

      expect(game).to be_unfinished
    end
  end

  describe '#answer!' do
    let(:player) { game.player(user) }
    subject do
      game.answer!(user, {
        :trivia_id => trivia.id,
        :trivia_option_id => trivia.correct_option_id
      })
    end

    it 'answers with the given user' do
      expect(subject.player).to eql player
    end

    it 'answers with the trivia and option' do
      expect(subject.trivia).to eql trivia
    end

    it 'answers with the trivia and option' do
      expect(subject.trivia_option).to eql trivia.correct_option
    end
  end

  describe '#has_rounds?(user)' do
    let(:trivia1) { create(:trivia, :with_options) }
    let(:trivia2) { create(:trivia, :with_options) }
    let(:trivia3) { create(:trivia, :with_options) }

    it 'has rounds when the number of answers is less than the number of rounds' do
      game.answer!(user, {:trivia => trivia1, :trivia_option => trivia1.correct_option})

      expect(game).to have_rounds(user)
    end

    it 'does not have rounds when the number of answers is equal to the number of rounds' do
      game.answer!(user, {:trivia => trivia1, :trivia_option => trivia1.correct_option})
      game.answer!(user, {:trivia => trivia2, :trivia_option => trivia2.correct_option})

      expect(game).to_not have_rounds(user)
    end

    it 'does not have rounds when the number of answers is over the number of rounds' do
      game.answer!(user, {:trivia => trivia1, :trivia_option => trivia1.correct_option})
      game.answer!(user, {:trivia => trivia2, :trivia_option => trivia2.correct_option})
      game.answer!(user, {:trivia => trivia2, :trivia_option => trivia3.correct_option})

      expect(game).to_not have_rounds(user)
    end
  end
end
