require 'rails_helper'
require 'givdo/facebook'

RSpec.describe FriendsSerializer, :type => :serializer do
  let(:friend_user) { build(:user, :uid => 'user-1234')}
  let(:user) { build(:user, :uid => 'user-1234')}
  let(:friends) { Givdo::Facebook::Friends.new(nil, {}) }
  before { allow(friends).to receive(:next_page_params).and_return({page: 2}) }
  before { allow(friends).to receive(:users).and_return([friend_user]) }
  subject { serialize(friends, FriendsSerializer, :scope => user, :include => 'users') }

  it { is_expected.to serialize_link(:next).with(api_v1_friends_url({page: 2})) }
  it { is_expected.to serialize_id_and_type('user-1234', 'friends') }
  it { is_expected.to serialize_included(friend_user).with(FriendUserSerializer) }
end
