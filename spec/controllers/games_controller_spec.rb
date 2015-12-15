require 'rails_helper'

RSpec.describe GamesController, :type => :controller do
  describe 'POST /' do
    let(:game) { Game.new }
    let(:user) { User.new }
    before do
      allow(Game).to receive(:create!).with(creator: user).and_return(game)
    end

    it_behaves_like 'an authenticated only action' do
      subject { post(:create) }
    end

    context 'when request to invite users' do
      it 'creates the game with invitees' do
        api_user(user)
        expect(GameInvite).to receive(:invite!).with(game, 'facebook', ['1231244', '12312314', '12312414'])

        post(:create, {
          :provider => 'facebook',
          :invitees => ['1231244', '12312314', '12312414']
        })

        expect(response.body).to serialize_object(game).with(GameSerializer)
      end
    end

    context 'when no invites are sent' do
      it 'creates the game' do
        api_user(user)
        expect(GameInvite).to_not receive(:invite!)

        post(:create)

        expect(response.body).to serialize_object(game).with(GameSerializer)
      end
    end
  end
end
