require 'rails_helper'

RSpec.describe OauthCallbackController, :type => :controller do
  describe 'POST /oauth/facebook/callback' do
    let(:user) { double(User) }
    subject do
      post :facebook, {
        :provider => 'facebook',
        :uid => 'facebook id',
        :access_token => 'token 123',
        :expires_in => '5184000'
      }
    end
    before { allow(BetaAccess).to receive(:granted?).and_return(true) }

    it 'generates a token with the provider user' do
      expect(Givdo::OAuth::Facebook).to receive(:validate!).with('token 123').and_return(user)
      expect(UserToken).to receive(:generate).with(user, 5184000).and_return 'generated token'

      expect(subject).to be_success
      expect(subject.body).to eql '{"token":"generated token"}'
    end

    it 'formats oauth errors' do
      expect(Givdo::OAuth::Facebook).to receive(:validate!).and_raise(Givdo::OAuth::Error, 'error message')

      expect(subject).to be_bad_request
      expect(subject.body).to eql '{"error":"error message","code":"oauth"}'
    end

    describe 'beta access' do
      before { expect(Givdo::OAuth::Facebook).to receive(:validate!).and_return(user) }

      it 'does not authenticate fwhen the user is not part of the beta access program' do
        expect(BetaAccess).to receive(:granted?).with(user).and_return(false)

        expect(subject).to be_unauthorized
        expect(subject.body).to eql '{"error":"Beta access not granted","code":"beta"}'
      end
    end
  end
end
