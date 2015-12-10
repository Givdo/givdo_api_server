require 'rails_helper'

RSpec.describe GamesController, :type => :controller do
  describe 'POST /invite' do
    let(:game) { Game.new }
    let(:user) { User.new }
    subject do
      post(:invite, {
        :provider => 'facebook',
        :invitees => ['1231244', '12312314', '12312414']
      })
    end

    it_behaves_like 'an authenticated only action'

    it 'creates an invite from the current user to its invitees' do
      api_user(user)

      expect(GameInvite).to receive(:invite!)
        .with(user, 'facebook', ['1231244', '12312314', '12312414'])
        .and_return(game)

      expect(subject.body).to serialize_object(game).with(GameSerializer)
    end
  end
end
