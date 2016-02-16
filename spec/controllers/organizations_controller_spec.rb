require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  describe 'GET /' do
    before { allow(UpdateOrganizationJob).to receive(:perform_later) }
    let(:user) { build(:user) }
    let(:greenpeace) { build(:organization, :name => 'Greenpeace') }
    let(:i_wisth) { build(:organization, :name => 'I wish') }
    let(:pagination) { double('pagination', per: [greenpeace, i_wisth]) }
    let(:result) { double('result', :page => pagination)}
    let(:ransack) { double('ransack', :result => result) }
    before { allow(Organization).to receive(:ransack).and_return ransack }
    before { allow(Organization).to receive(:page).and_return pagination }
    before { api_user user }
    subject { get :index, :format => :json }

    it_behaves_like 'an authenticated only action'

    it 'renders a json the returned organizations' do
      expect(subject.body).to serialize_collection([greenpeace, i_wisth]).with(OrganizationSerializer)
    end

    it 'perform a organization update for each organization' do
      expect(UpdateOrganizationJob).to receive(:perform_later).once.with(greenpeace)
      expect(UpdateOrganizationJob).to receive(:perform_later).once.with(i_wisth)

      subject
    end

    describe 'pagination' do
      it 'searches by the given term' do
        expect(Organization).to receive(:ransack).with('i wish').and_return(ransack)

        get :index, :search => 'i wish'
      end

      it 'paginates to the given page' do
        expect(Organization).to receive(:page).with(10).and_return pagination

        get :index, :page => {:number => 10}, :format => :json
      end

      it 'defaults to 10 organizations per page' do
        expect(pagination).to receive(:per).with(10).and_return []

        get :index, :format => :json
      end

      it 'accepts arbitrary number of organizations per page' do
        expect(pagination).to receive(:per).with(15).and_return []

        get :index, :page => {:size => 15}, :format => :json
      end
    end
  end
end
