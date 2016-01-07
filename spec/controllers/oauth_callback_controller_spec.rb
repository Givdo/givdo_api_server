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

    it 'generates a token with the provider user' do
      expect(Givdo::OAuth::Facebook).to receive(:validate!).with('token 123').and_return(user)
      expect(UserToken).to receive(:generate).with(user, 5184000).and_return 'generated token'

      expect(subject).to be_success
      expect(subject.body).to eql '{"token":"generated token"}'
    end

    it 'formats oauth errors' do
      expect(Givdo::OAuth::Facebook).to receive(:validate!).and_raise(Givdo::OAuth::Error, 'error message')

      expect(subject.code).to eql '400'
      expect(subject.body).to eql '{"error":"error message"}'
    end
  end
end
