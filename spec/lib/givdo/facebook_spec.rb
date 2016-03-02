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

  describe '.graph(token)' do
    context 'when a token is not given' do
      it 'is a koala facebook client with the app token' do
        expect(subject).to receive(:oauth).and_return(double(get_app_access_token: 'app token'))

        graph = subject.graph

        expect(graph).to be_a Koala::Facebook::API
        expect(graph.access_token).to eql 'app token'
      end
    end

    context 'when a token given' do
      it 'is a koala facebook client with the token token' do
        expect(subject).to_not receive(:oauth)

        graph = subject.graph('user token')

        expect(graph).to be_a Koala::Facebook::API
        expect(graph.access_token).to eql 'user token'
      end
    end
  end

  describe '.friend' do
    let(:friend_user) { }
    let(:user) { double(:provider_token => 'user token') }
    let(:user_graph) { double }
    before { allow(Givdo::Facebook).to receive(:graph).with('user token').and_return(user_graph) }

    it 'is the object with the given uid from the given user graph' do
      profile = {'name' => 'George Foreman', 'id' => 'friend-uid'}
      expect(user_graph).to receive(:get_object).with('friend-uid', {:param => 'value'}).and_return(profile)
      expect(Givdo::Facebook::User).to receive(:get).with(profile).and_return(friend_user)

      Givdo::Facebook.friend(user, 'friend-uid', {:param => 'value'})
    end
  end
end
