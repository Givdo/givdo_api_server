require 'rails_helper'

RSpec.describe OauthCallbackController, type: :controller do
  describe 'assign_provider_attrs' do
    let(:user) { User.new }
    let(:auth_info) { {'credentials' => {'token' => 'ABC'}, 'info' => {'name' => 'John Doe'}} }
    before { subject.assign_provider_attrs(user, auth_info) }

    it 'assigns the oauth credentials' do
      expect(user.provider_token).to eql({'token' => 'ABC'})
    end

    it 'assigns the user info' do
      expect(user.name).to eql 'John Doe'
    end
  end
end
