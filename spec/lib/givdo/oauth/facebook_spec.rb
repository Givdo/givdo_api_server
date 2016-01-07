require 'rails_helper'
require 'givdo/oauth'

RSpec.describe Givdo::OAuth::Facebook, :type => :model do
  describe '#validate!' do
    let(:facebook_profile) { {} }
    let(:graph) { double(:get_object => {}, :get_picture => nil) }
    subject { Givdo::OAuth::Facebook.validate!('access token') }
    before { allow(Givdo::Facebook).to receive(:graph).with('access token').and_return(graph) }
    before { allow(graph).to receive(:get_object).with('me').and_return(facebook_profile) }

    it 'fetches the user given the token and name' do
      facebook_profile['id'] = 'facebook id'
      facebook_profile['name'] = 'User Real Name'

      expect(User).to receive(:for_provider!).with(:facebook, 'facebook id', a_hash_including({
        :name => 'User Real Name'
      })).and_return('user')

      expect(subject).to eql 'user'
    end

    it 'fetches the user picture' do
      expect(graph).to receive(:get_picture).with('me').and_return('picture')

      expect(User).to receive(:for_provider!).with(anything, anything, a_hash_including({
        :image => 'picture'
      })).and_return('user')

      expect(subject).to eql 'user'
    end

    it 'saves the new token' do
      expect(graph).to receive(:get_picture).with('me').and_return('picture')

      expect(User).to receive(:for_provider!).with(anything, anything, a_hash_including({
        :provider_token => 'access token'
      })).and_return('user')

      expect(subject).to eql 'user'
    end

    it 'raises an OAuth::Error in case of any problem' do
      expect(graph).to receive(:get_object).and_raise(Koala::Facebook::AuthenticationError.new(10, 'message'))

      expect { subject }.to raise_error Givdo::OAuth::Error, 'message [HTTP 10]'
    end
  end
end
