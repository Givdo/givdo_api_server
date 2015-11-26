require 'rails_helper'
require 'givdo/facebook'

RSpec.describe Givdo::Facebook, type: :lib do
  describe 'oauth' do
    it 'is a koala facebook oauth using the secrets credentials' do
      allow(Rails.application.secrets).to receive(:facebook).and_return({
        'app_id' => 'my-app-id',
        'secret' => 'my-app-secret'
      })
      expect(subject.oauth).to be_a Koala::Facebook::OAuth
      expect(subject.oauth.app_id).to eql 'my-app-id'
      expect(subject.oauth.app_secret).to eql 'my-app-secret'
    end
  end

  describe '.graph(user)' do
    context 'when a token is not given' do
      it 'is a koala facebook client with the app token' do
        expect(subject).to receive(:oauth).and_return(double(get_app_access_token: 'app token'))

        graph = subject.graph

        expect(graph).to be_a Koala::Facebook::API
        expect(graph.access_token).to eql 'app token'
      end
    end

    context 'when a token given' do
      it 'is a koala facebook client with the user token' do
        expect(subject).to_not receive(:oauth)

        user = double(provider_access_token: 'user token')
        graph = subject.graph(user)

        expect(graph).to be_a Koala::Facebook::API
        expect(graph.access_token).to eql 'user token'
      end
    end
  end
end
