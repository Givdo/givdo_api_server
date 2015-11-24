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
end
