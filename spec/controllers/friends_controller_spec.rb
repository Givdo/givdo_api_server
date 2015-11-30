require 'rails_helper'
require 'givdo/facebook'

RSpec.describe FriendsController, type: :controller do
  let(:current_user) { build(:user) }

  describe 'GET /friends' do
    let(:friends) { Givdo::Facebook::PaginatedConnections.new(nil, nil, nil) } # Any activemodel, since stubbing doesn't give you a model_name
    before do
      allow(friends).to receive(:next_page_params).and_return([])
      allow(friends).to receive(:list).and_return([])
    end

    it_behaves_like 'an authenticated only action' do
      subject { get :index, :format => :json }
    end

    it 'renders 100 facebook invitable friends from the user' do
      api_user(current_user)
      expect(Givdo::Facebook).to receive(:invitable_friends).with(current_user, hash_including(:limit => 100)).and_return(friends)

      get :index, :format => :json

      expect(response.body).to serialize_object(friends).with(FriendsListSerializer)
    end

    it 'renders the page given by page parameter' do
      api_user(current_user)
      expect(Givdo::Facebook).to receive(:invitable_friends).with(current_user, hash_including(:page => ['next', {:page => 'param'}], :limit => 100)).and_return(friends)

      get :index, :page => ['next', {:page => 'param'}], :format => :json

      expect(response.body).to serialize_object(friends).with(FriendsListSerializer)
    end
  end
end
