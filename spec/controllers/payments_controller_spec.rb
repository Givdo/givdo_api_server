require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe 'GET /token' do
    let(:body) { JSON.parse(subject.body) }
    subject { get :token }

    it 'generates a token and returns it' do
      allow(Braintree::ClientToken).to receive(:generate).and_return('generated token')

      expect(body).to eql({'token' => 'generated token'})
    end
  end
end
