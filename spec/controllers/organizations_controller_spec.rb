require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  describe 'GET /' do
    before { allow(UpdateOrganizationJob).to receive(:perform_later) }
    let(:body) { JSON.parse(subject.body) }
    let(:greenpeace) { build(:organization, :name => 'Greenpeace') }
    let(:i_wisth) { build(:organization, :name => 'I wish') }
    let(:pagination) { double(per: [greenpeace, i_wisth]) }
    subject { get :index, :format => :json }

    it 'renders a json the returned organizations' do
      allow(Organization).to receive(:page).and_return pagination

      names = body.map{|o| o['name']}

      expect(names).to match_array ['Greenpeace', 'I wish']
    end

    it 'perform a organization update for each organization' do
      allow(Organization).to receive(:page).and_return pagination

      expect(UpdateOrganizationJob).to receive(:perform_later).once.with(greenpeace)
      expect(UpdateOrganizationJob).to receive(:perform_later).once.with(i_wisth)

      subject
    end

    describe 'pagination' do
      it 'paginates to the given page' do
        allow(Organization).to receive(:page).with(10).and_return pagination

        get :index, :page => 10, :format => :json
      end

      it 'defaults to 10 organizations per page' do
        allow(Organization).to receive(:page).and_return pagination
        expect(pagination).to receive(:per).with(10).and_return []

        get :index, :format => :json
      end

      it 'accepts arbitrary number of organizations per page' do
        allow(Organization).to receive(:page).and_return pagination
        expect(pagination).to receive(:per).with(15).and_return []

        get :index, :per_page => 15, :format => :json
      end
    end
  end
end
