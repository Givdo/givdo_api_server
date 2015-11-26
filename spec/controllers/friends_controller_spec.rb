require 'rails_helper'
require 'givdo/facebook'

RSpec.describe FriendsController, type: :controller do
  let(:friends) { Givdo::Facebook::PaginatedConnections.new(nil, nil, nil) } # Any activemodel, since stubbing doesn't give you a model_name
  let(:current_user) { build(:user) }

  describe 'GET /friends' do
    subject { get :index, :format => :json }

    it_behaves_like 'an authenticated only action'

    it 'renders the facebook invitable friends from the user' do
      api_user(current_user)

      allow(friends).to receive(:next_page_params).and_return([])
      allow(friends).to receive(:list).and_return([])

      expect(Givdo::Facebook).to receive(:invitable_friends).with(current_user, anything).and_return(friends)
      expect(subject.body).to serialize_object(friends).with(FriendsListSerializer)
    end
  end
end
