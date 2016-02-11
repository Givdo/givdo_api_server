require 'rails_helper'

RSpec.describe ApplicationController, :type => :controller do
  let(:user) { double(:id => 10) }

  describe 'filters' do
    controller do
      before_filter :authenticate_user!

      def index
        render :text => 'you are in'
      end
    end

    describe 'authenticate_user!' do
      subject { get :index }
      before { allow(BetaAccess).to receive(:granted?).and_return(true) }

      it 'does not authorize unidentified access' do
        expect(subject).to be_unauthorized
      end

      it 'authorizes identified user' do
        api_user(user)

        expect(subject).to be_success
        expect(subject.body).to eql 'you are in'
      end

      it 'does not authorize users without beta access' do
        api_user(user)

        expect(BetaAccess).to receive(:granted?).with(user).and_return(false)

        expect(subject).to be_unauthorized
      end
    end
  end

  describe '#current_user' do
    controller do
      def index
        @user = current_user

        render :text => 'you are always in'
      end
    end
    subject { get :index }

    it 'denies the access when the user sends an invalid token' do
      api_user(user)
      allow(UserToken).to receive(:authenticate).and_raise(UserToken::InvalidToken)

      expect(subject.code).to eql '401'
    end

    it 'is the user when it is valid' do
      api_user(user)

      subject

      expect(assigns(:user)).to be user
    end

    it 'is nil when no user is sent' do
      subject

      expect(assigns(:user)).to be_nil
    end
  end
end
