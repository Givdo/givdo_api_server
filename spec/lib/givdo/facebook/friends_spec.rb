require 'rails_helper'
require 'givdo/facebook'

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
      expect(subject).to receive(:list).and_return(friends_list)
      expect(Givdo::Facebook::User).to receive(:list)
        .with(friends_list)
        .and_return([user1, user2])

      expect(subject.users).to match_array [user1, user2]
    end
  end
end
