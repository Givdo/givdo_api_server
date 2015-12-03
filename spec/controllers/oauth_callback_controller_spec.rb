require 'rails_helper'

RSpec.describe OauthCallbackController, :type => :controller do
  describe 'POST /oauth/:provider/callback' do
    let(:user) { double(:save!) }
    subject do
      post :callback, {
        :provider => 'facebook',
        :uid => 'facebook id',
        :access_token => 'token 123',
        :expires_in => '5184000'
      }
    end

    it 'generates a token with the provider user' do
      expect(User).to receive(:for_provider).with('facebook', 'facebook id', 'token 123').and_return(user)
      expect(UserToken).to receive(:generate).with(user, 5184000).and_return 'generated token'

      expect(subject).to be_success
      expect(subject.body).to eql '{"token":"generated token"}'
    end
  end
end
