require 'rails_helper'

RSpec.describe PlayerController, :type => :controller do
  let(:game) { build(:game, :id => 10) }
  let(:player) { build(:player, :game => game) }
  let(:user) { player.user }

  describe 'PATCH /games/:game_id/player' do
    subject { patch :update, {game_id: 10, organization_id: 20} }

    it_behaves_like 'an authenticated only action'

    it 'updates the player data in the game' do
      allow(Game).to receive(:find).with('10').and_return(game)
      allow(game).to receive(:player).with(user).and_return(player)
      expect(player).to receive(:update!).with(organization_id: '20')

      api_user user

      expect(subject.body).to serialize_object(game).with(GameSerializer, {
        :scope => user,
        :include => 'player,trivia,trivia.options'
      })
    end
  end
end
