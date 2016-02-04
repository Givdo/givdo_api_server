require 'rails_helper'
require 'givdo/facebook/friends'

RSpec.describe Givdo::Facebook::Friends, :type => :lib do
  let(:user1) { double }
  let(:user2) { double }
  let(:params) { {} }
  let(:graph) { double(:get_connections => []) }
  subject { Givdo::Facebook::Friends.new(graph, params) }

  describe '#users' do
    it 'is the list of friends users' do
      expect(subject).to receive(:list).and_return([
        {'id' => '123456'},
        {'id' => '654321'}
      ])
      expect(User).to receive(:for_provider_batch!)
        .with(:facebook, ['123456', '654321'])
        .and_return([user1, user2])
      expect(subject.users).to match_array [user1, user2]
    end
  end
end
