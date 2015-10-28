require 'rails_helper'

RSpec.describe PaymentsController, :type => :controller do
  let(:user) { build(:user) }
  let(:body) { JSON.parse(subject.body) }
  before { api_user(user) }

  describe 'GET /token' do
    subject { get :token }

    it 'generates a token and returns it' do
      allow(Braintree::ClientToken).to receive(:generate).and_return('generated token')

      expect(subject).to be_success
      expect(body).to eql({'token' => 'generated token'})
    end
  end

  describe "POST /" do
    subject { post :create, {:nonce => 'credit-card-nonce', :amount => '10.00'} }

    it 'creates the payment method from the given nonce' do
      expect(ProcessPaymentJob).to receive(:perform_later).with(user, 'credit-card-nonce', '10.00')

      expect(subject).to be_success
      expect(body).to eql({'success' => true})
    end
  end
end
