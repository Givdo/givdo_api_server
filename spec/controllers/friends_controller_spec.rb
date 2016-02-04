require 'rails_helper'

RSpec.describe FriendsController, :type => :controller do
  let(:user) { build(:user) }

  describe "GET #index" do
    subject { get :index }

    it_behaves_like 'an authenticated only action'

    describe 'authenticated user' do
      let(:friends) { Givdo::Facebook::Friends.new(nil, nil) }
      before { allow(friends).to receive(:next_page_params).and_return({}) }
      before { allow(friends).to receive(:users).and_return([user]) }
      before { allow(Givdo::Facebook).to receive(:friends).with(user, {}).and_return(friends) }
      before { api_user(user) }

      it { is_expected.to have_http_status(:success) }
      it { is_expected.to serialize_object(friends).with(FriendsSerializer, :scope => user) }
    end
  end
end
