require 'rails_helper'

RSpec.describe Givdo::TokenAuth do
  describe '.recover' do
    let(:user) { double(:to_sgid => 'signed.locator') }
    let(:session) { Givdo::TokenAuth::Session.new(user, 1.year.from_now.to_i)}
    let(:expired_session) { Givdo::TokenAuth::Session.new(user, 1.year.ago.to_i)}
    subject { Givdo::TokenAuth.recover(session.token) }

    it 'locates the user by the signed global id' do
      allow(GlobalID::Locator).to receive(:locate_signed).with('signed.locator').and_return('user')

      recovered_session = Givdo::TokenAuth.recover(session.token)

      expect(recovered_session.user).to eql 'user'
    end

    it 'raises an invalid token exception when locator is invalid' do
      expect { Givdo::TokenAuth.recover(session.token) }.to raise_error Givdo::TokenAuth::InvalidToken
    end

    it 'raises an invalid token exception when the user does not exist' do
      user = create(:user).tap(&:destroy)
      session = Givdo::TokenAuth::Session.new(user, 1.year.from_now.to_i)

      expect { Givdo::TokenAuth.recover(session.token) }.to raise_error Givdo::TokenAuth::InvalidToken
    end

    it 'raises an invalid token when the token is expired' do
      expect { Givdo::TokenAuth.recover(expired_session.token) }.to raise_error Givdo::TokenAuth::InvalidToken
    end

    it 'raises an invalid token when the token is invalid' do
      expect { Givdo::TokenAuth.recover('invalid token') }.to raise_error Givdo::TokenAuth::InvalidToken
    end
  end
end
