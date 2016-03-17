require 'rails_helper'

RSpec.describe UserSerializer, :type => :serializer do
  let(:organization) { build(:organization) }
  let(:user) do
    build(:user, {
      :id => 1114,
      :organization => organization,
      :name => 'John Doe',
      :image => 'http://user.com/profile.jpg',
      :cover => 'http://user.com/cover.jpg',
      :email => 'user@email.com'
    })
  end
  subject { serialize(user, UserSerializer, :include => 'organization') }

  it { is_expected.to serialize_id_and_type('1114', 'users') }
  it { is_expected.to serialize_link(:self).with(user_url(user)) }

  it { is_expected.to serialize_attribute(:name).with('John Doe') }
  it { is_expected.to serialize_attribute(:image).with('http://user.com/profile.jpg') }
  it { is_expected.to serialize_attribute(:cover).with('http://user.com/cover.jpg') }
  it { is_expected.to serialize_attribute(:email).with('user@email.com') }

  it { is_expected.to serialize_included(organization).with(OrganizationSerializer) }
end
