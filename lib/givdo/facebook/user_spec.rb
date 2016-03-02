require 'rails_helper'
require 'givdo/facebook'

RSpec.describe Givdo::Facebook::User, :type => :lib do
  let(:user) { double }

  describe '.get' do
    it 'adds the user picture to the user attributes' do
      expect(::User).to receive(:for_provider!).with(:facebook, 'user-id', {
        'name' => 'User Name',
        'image' => 'https://graph.facebook.com/user-id/picture'
      }).and_return(user)

      user_with_facebook = Givdo::Facebook::User.get({'id' => 'user-id', 'name' => 'User Name'})

      expect(user_with_facebook).to be user
    end
  end

  describe '.list' do
    it 'adds the user picture to the users attributes' do
      expect(::User).to receive(:for_provider_batch!).with(:facebook, [{
        'id' => 'user-id',
        'name' => 'User Name',
        'image' => 'https://graph.facebook.com/user-id/picture'
      }]).and_return([user])

      users_with_facebook = Givdo::Facebook::User.list([{'id' => 'user-id', 'name' => 'User Name'}])

      expect(users_with_facebook).to match_array [user]
    end
  end
end
