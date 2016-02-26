require 'rails_helper'

RSpec.describe Game, :type => :model do
  let(:trivia) { create(:trivia, :with_options) }
  let(:user) { create(:user) }
  let(:game) { Game.new(:creator => user, :rounds => 2) }
  before { allow(TriviaRaffle).to receive(:raffle).and_return([trivia]) }

  it 'includes the creator in the players list' do
    game.save!

    expect(game.users).to match_array [user]
  end

  describe '#next_trivia(user)' do
    before { game.save! }

    it 'is a trivia the player never answered' do
      unanswered_trivia = create(:trivia)
      game.trivias << unanswered_trivia
      game.answer!(user, {
        :trivia_id => trivia.id,
        :trivia_option_id => trivia.correct_option_id
      })

      expect(game.next_trivia(user)).to eql unanswered_trivia
    end
  end

  describe '#trivias' do
    it 'raffles the trivias `round` times' do
      expect(TriviaRaffle).to receive(:raffle).with(game, 2).and_return([trivia])

      game.save!

      expect(game.trivias.pluck(:id)).to eql [trivia.id]
    end
  end

  describe '#single?' do
    before { game.save! }

    it 'is single when no other user is playing' do
      expect(game).to be_single
    end

    it 'is not single when when played with more users' do
      game.add_player(build(:user))

      expect(game).to_not be_single
    end
  end

  describe '#player' do
    before { game.save! }

    it 'is the player of the user in the game' do
      another_user = create(:user)
      player = game.add_player(another_user)
      game.save

      expect(game.player(another_user)).to eql player
    end

    it 'is nil if the user has no player in the game' do
      user = create(:user)
      game.players.where(:user => user).destroy_all

      expect(game.player(user)).to be_nil
    end
  end

  describe '#finished?' do
    before { game.save! }

    it 'is unfinished when every player have finished' do
      game.players.update_all(:finished_at => DateTime.current)

      expect(game).to be_finished
    end

    it 'is not unfinished when any player still have not finished' do
      game.players.update_all(:finished_at => nil)

      expect(game).to_not be_finished
    end
  end
end
