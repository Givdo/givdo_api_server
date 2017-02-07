require 'rails_helper'
require 'givdo/oauth'

RSpec.describe Givdo::Oauth::Facebook, :type => :model do
  describe '#validate!' do
    subject { Givdo::Oauth::Facebook.validate!('access token') }

    let(:facebook_profile) { {'id' => 'facebook id'} }
    let(:graph) { double(:get_object => {}, :get_picture_data => {}) }

    before do
      allow(Givdo::Facebook).to receive(:graph).with('access token').and_return(graph)
      allow(graph).to receive(:get_object).with('me', :fields => 'id,name,cover,email').and_return(facebook_profile)
    end

    it 'fetches the user given the token and name' do
      facebook_profile['name'] = 'User Real Name'

      expect(User).to receive(:for_provider!).with(:facebook, 'facebook id', a_hash_including({
        :name => 'User Real Name'
      })).and_return('user')

      expect(subject).to eql 'user'
    end

    it 'updates the user cover picture from graph' do
      facebook_profile['cover'] = {'source' => 'http://cover.picture.com'}

      expect(User).to receive(:for_provider!).with(:facebook, 'facebook id', a_hash_including({
        :cover => 'http://cover.picture.com'
      })).and_return('user')

      expect(subject).to eql 'user'
    end

    it 'fetches the user picture' do
      expect(graph).to receive(:get_picture_data).with('me').and_return({ 'url' => 'picture' })

      expect(User).to receive(:for_provider!).with(anything, anything, a_hash_including({
        :image => 'picture'
      })).and_return('user')

      expect(subject).to eql 'user'
    end

    it 'saves the new token' do
      expect(graph).to receive(:get_picture_data).with('me').and_return({ 'url' => 'picture' })

      expect(User).to receive(:for_provider!).with(anything, anything, a_hash_including({
        :provider_token => 'access token'
      })).and_return('user')

      expect(subject).to eql 'user'
    end

    it 'raises an Oauth::Error in case of any problem' do
      expect(graph).to receive(:get_object).and_raise(Koala::Facebook::AuthenticationError.new(10, 'message'))

      expect { subject }.to raise_error Givdo::Oauth::Error, 'message [HTTP 10]'
    end
  end
end
