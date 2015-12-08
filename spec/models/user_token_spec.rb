require 'rails_helper'

RSpec.describe UserToken, :type => :model do
  let(:user_10) { double(:id => 10) }
  let(:user_10_token) { 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJkYXRhIjoxMH0.s67cpLcHEhoB5st77erbMtHdZgtgUvtlS7G6fXpLX9U' }
  let(:expired_token) { 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJkYXRhIjoxMCwiZXhwIjoxNDQ5MTc3NDI0fQ.KYDby7X9A106RSE8LSiQIX8cDQPeDko0Om6J6wk51Lg' }
  subject { UserToken.new('encription salt', 'HS256') }

  describe '#generate' do
    it 'generates a token with the user id in the data with the given salt and algorithm' do
      expect(subject.generate(user_10, false)).to eql user_10_token
    end

    it 'generates a token after the given number of seconds' do
      Timecop.freeze(Time.new(0)) do
        expect(subject.generate(user_10, 70)).to eql 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJkYXRhIjoxMCwiZXhwIjotNjIxNjcyMDgzMzB9.yLz8w7-tIj4znhgjdZnKprr9Y2TTOkrKHTJbg752E8o'
      end
    end
  end

  describe '#authenticate' do
    it 'locates the user by the id in the token data' do
      allow(User).to receive(:find).with(10).and_return(user_10)

      expect(subject.authenticate(user_10_token)).to be user_10
    end

    it 'raises an invalid token exception when the user does not exist' do
      allow(User).to receive(:find).with(10).and_raise(ActiveRecord::RecordNotFound.new(nil))

      expect { subject.authenticate(user_10_token) }.to raise_error UserToken::InvalidToken
    end

    it 'raises an invalid token when the token is expired' do
      expect { subject.authenticate(expired_token) }.to raise_error UserToken::InvalidToken
    end

    it 'raises an invalid token when the token is invalid' do
      expect { subject.authenticate('invalid token') }.to raise_error UserToken::InvalidToken
    end
  end

  describe '.default' do
    it 'is a user token witht he rails secret key base and HS256 algorithm' do
      allow(Rails.application.secrets).to receive(:secret_key_base).and_return('secret key')

      expect(UserToken).to receive(:new).with('secret key', 'HS256').and_return('user token')

      expect(UserToken.default).to eql 'user token'
    end
  end
end
