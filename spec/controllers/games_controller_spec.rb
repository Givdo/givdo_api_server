require 'rails_helper'

RSpec.describe GamesController, :type => :controller do
  let(:game) { Game.new(:id => 10) }
  let(:user) { User.new }
  before do
    allow(game).to receive(:next_trivia).and_return(nil)
    allow(Game).to receive(:find).with('10').and_return(game)
  end

  describe 'GET /single' do
    subject { get :single }

    it_behaves_like 'an authenticated only action'

    it 'gets the user current signel player game' do
      expect(user).to receive(:current_single_game).and_return(game)

      api_user(user)

      expect(subject).to serialize_object(game).with(GameSerializer, :include => 'player,trivia,trivia.options')
    end
  end

  describe 'GET /versus/:uid' do
    let(:friend) { User.new }
    subject { get(:versus, :uid => '12345') }

    it_behaves_like 'an authenticated only action'

    it 'gets the last game of the current user versus the friend given its uid and the user provider' do
      user.provider = 'facebook'
      expect(User).to receive(:for_provider!).with('facebook', '12345').and_return(friend)
      expect(user).to receive(:current_game_versus).with(friend).and_return(game)

      api_user(user)

      expect(subject).to serialize_object(game).with(GameSerializer, :include => 'player,trivia,trivia.options')
    end
  end
end
