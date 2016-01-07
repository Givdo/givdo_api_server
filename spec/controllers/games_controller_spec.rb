require 'rails_helper'

RSpec.describe GamesController, :type => :controller do
  let(:game) { Game.new(:id => 10) }
  let(:user) { User.new }
  before do
    allow(Game).to receive(:find).with('10').and_return(game)
  end

  describe 'GET /single' do
    subject { get :single }

    it_behaves_like 'an authenticated only action'

    it 'gets the user current signel player game' do
      expect(user).to receive(:current_single_game).and_return(game)

      api_user user

      expect(subject.body).to serialize_object(game).with(GameSerializer)
    end
  end

  describe 'POST /' do
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

  describe 'GET /raffle' do
    let(:trivia) { build(:trivia) }
    subject { get :raffle, :id => 10 }

    it_behaves_like 'an authenticated only action'

    it 'raffles in the current user scope' do
      expect(TriviaRaffle).to receive(:next).with(user, game).and_return(trivia)

      api_user user

      expect(subject.body).to serialize_object(trivia).with(TriviaSerializer)
    end
  end
end
