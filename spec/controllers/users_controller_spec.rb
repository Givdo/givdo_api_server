require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'PATCH /user' do
    let(:user) { build(:user) }
    let(:data) { {} }
    subject { patch :update, data }

    it_behaves_like 'an authenticated only action'

    describe 'successful update' do
      it 'updates the current user organization' do
        api_user user

        data[:organization_id] = 10

        expect(user).to receive(:update_attributes!).with({'organization_id' => '10'})
        expect(subject).to be_success
        expect(subject.body).to serialize_object(user).with(UserSerializer, :include => 'organization')
      end
    end
  end

  describe 'GET /user' do
    let(:user) { build(:user) }
    subject { get :show }

    it_behaves_like 'an authenticated only action'

    describe 'successful call' do
      it 'gets the user data' do
        api_user user

        expect(subject).to be_success
        expect(subject.body).to serialize_object(user).with(UserSerializer, :include => 'organization')
      end
    end
  end
end
