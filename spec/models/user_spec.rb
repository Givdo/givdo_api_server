require 'rails_helper'

RSpec.describe User, type: :model do
  describe "provider_access_token" do
    it 'is the token from the provider token hash' do
      subject.provider_token = {'token' => 'user token'}

      expect(subject.provider_access_token).to eql 'user token'
    end

    it 'is nil if the user has no token' do
      subject.provider_token = nil

      expect(subject.provider_access_token).to be_nil
    end
  end

  describe '.for_provider!' do
    subject { User.for_provider!('facebook', 'facebook id', 'token') }

    it 'is the existing user by the provider and provider id' do
      user = create(:user, {
        :provider => 'facebook',
        :uid => 'facebook id',
        :provider_token => 'old token'
      })

      expect(subject).to eql user
      expect(subject.provider_token).to eql 'token'
    end

    it 'is an initialized user with the provider and provider id if one does not exist' do
      User.where(:provider => 'facebook', :uid => 'facebook id').destroy_all

      expect(subject).to be_persisted
      expect(subject.provider).to eql 'facebook'
      expect(subject.uid).to eql 'facebook id'
      expect(subject.provider_token).to eql 'token'
    end
  end
end
