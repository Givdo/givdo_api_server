require 'rails_helper'
require 'givdo/facebook/friends'

RSpec.describe Givdo::Facebook::Friends, :type => :lib do
  let(:user1) { double }
  let(:user2) { double }
  let(:params) { {} }
  let(:graph) { double(:get_connections => []) }
  subject { Givdo::Facebook::Friends.new(graph, params) }

  describe '#users' do
    it 'is the list of friends users with pictures' do
      friends_list = [
        {'id' => '123456'},
        {'id' => '654321'}
      ]
      friends_list_with_image = [
        {'id' => '123456', 'image' => 'https://graph.facebook.com/123456/picture'},
        {'id' => '654321', 'image' => 'https://graph.facebook.com/654321/picture'}
      ]
      expect(subject).to receive(:list).and_return(friends_list)
      expect(User).to receive(:for_provider_batch!)
        .with(:facebook, friends_list_with_image)
        .and_return([user1, user2])

      expect(subject.users).to match_array [user1, user2]
    end
  end
end
