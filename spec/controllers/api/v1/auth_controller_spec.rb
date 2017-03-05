require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :controller do
  before { allow(session).to receive(:token).and_return('12345') }
  before { allow(BetaAccess).to receive(:granted?).and_return(true) }

  describe 'POST /oauth/facebook/callback' do
    let(:user) { User.create(uid: 1, provider: 'test') }
    let(:session) { Givdo::TokenAuth::Session.new(user, 5184000) }

    subject do
      post :facebook, {
        :provider => 'facebook',
        :uid => 'facebook id',
        :access_token => 'token 123',
        :expires_in => '5184000'
      }
    end

    it 'generates a token with the provider user' do
      Timecop.freeze(Date.parse('2015-10-10'))
      expect(Givdo::Oauth::Facebook).to receive(:validate!).with('token 123').and_return(user)
      expect(Givdo::TokenAuth::Session).to receive(:new).with(user, '5184000').and_return session

      expect(subject).to be_success
      expect(subject).to serialize_object(session).with(SessionSerializer, :include => 'user.*')
    end

    it 'formats oauth errors' do
      expect(Givdo::Oauth::Facebook).to receive(:validate!).and_raise(Givdo::Oauth::Error, 'error message')

      expect(subject).to be_bad_request
      expect(subject.body).to eql '{"error":"error message","code":"oauth"}'
    end

    describe 'beta access' do
      before { allow(Givdo::Oauth::Facebook).to receive(:validate!).and_return(user) }

      it 'does not authenticate fwhen the user is not part of the beta access program' do
        pending('uncommenting code in auth_controller')
        expect(BetaAccess).to receive(:granted?).with(user).and_return(false)

        expect(subject).to be_unauthorized
        expect(subject.body).to eql '{"error":"Beta access not granted","code":"beta"}'
      end
    end
  end
end
