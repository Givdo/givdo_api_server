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

  describe '#finished?' do
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
