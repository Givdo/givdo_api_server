require 'rails_helper'
require 'givdo/facebook'

RSpec.describe FriendsSerializer, :type => :serializer do
  let(:user) { build(:user, :uid => 'user-1234')}
  let(:friends) { Givdo::Facebook::Friends.new(nil, nil) }
  before { allow(friends).to receive(:next_page_params).and_return({page: 2}) }
  subject { serialize(friends, FriendsSerializer, :scope => user) }

  it { is_expected.to serialize_link(:next).with(friends_url({page: 2})) }
  it { is_expected.to serialize_id_and_type('user-1234', 'friends') }
end
