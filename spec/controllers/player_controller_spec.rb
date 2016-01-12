require 'rails_helper'

RSpec.describe PlayerController, :type => :controller do
  let(:player) { build(:player) }
  let(:game) { player.game }
  let(:user) { player.user }

  before do
    allow(Game).to receive(:find).with('10').and_return(game)
    allow(game).to receive(:player).with(user).and_return(player)
  end

  describe 'PATCH /games/:game_id/player' do
    subject { patch :update, {game_id: 10, organization_id: 20} }

    it_behaves_like 'an authenticated only action'

    it 'updates the player data in the game' do
      expect(player).to receive(:update!).with(organization_id: '20')

      api_user user

      expect(subject.body).to serialize_object(game).with(GameSerializer, :scope => user)
    end
  end
end
