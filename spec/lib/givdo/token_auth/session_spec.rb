require 'rails_helper'
require 'givdo/token_auth/session'

describe Givdo::TokenAuth::Session, :type => :lib do
  describe '#token' do
    let(:user) { double(:to_sgid => 'user.sgid') }
    let(:session_no_exp) { Givdo::TokenAuth::Session.new(user, false) }
    let(:session_10_exp) { Givdo::TokenAuth::Session.new(user, 10) }

    it 'does not include any exp when no exp time is given' do
      expect(session_no_exp.token).to eql 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJkYXRhIjoidXNlci5zZ2lkIiwiZXhwIjpudWxsfQ.FZyfir9smbWb_JOnpD4OrB2JhLKkN3f033J88IB_qrE'
    end

    it 'does not include any exp when no exp time is given' do
      expect(session_no_exp.token).to eql 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJkYXRhIjoidXNlci5zZ2lkIiwiZXhwIjpudWxsfQ.FZyfir9smbWb_JOnpD4OrB2JhLKkN3f033J88IB_qrE'
    end
  end
end
