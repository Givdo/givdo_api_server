require 'rails_helper'

RSpec.describe FriendUserSerializer, :type => :serializer do
  subject { serialize(user, FriendUserSerializer) }

  let(:user) { build(:user, :provider => 'facebook', :uid => 'user-1234', :name => 'John Doe', :image => 'http://www.givdo.com/image.jpg')}

  it { is_expected.to serialize_attribute(:name).with('John Doe') }
  it { is_expected.to serialize_attribute(:image).with('http://www.givdo.com/image.jpg') }
  it { is_expected.to serialize_attribute(:uid).with('user-1234') }
  it { is_expected.to serialize_attribute(:provider).with('facebook') }
end
