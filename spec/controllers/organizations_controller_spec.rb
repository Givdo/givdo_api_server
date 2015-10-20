require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  describe 'GET /' do
    before { allow(UpdateOrganizationJob).to receive(:perform_later) }
    let(:body) { JSON.parse(subject.body) }
    let!(:greenpeace) { Organization.create(:name => 'Greenpeace') }
    let!(:i_wisth) { Organization.create(:name => 'I wish') }
    subject { get :index, :format => :json }

    it 'renders a json of all organizations' do
      names = body.map{|o| o['name']}

      expect(names).to match_array ['Greenpeace', 'I wish']
    end

    it 'perform a organization update for each organization' do
      expect(UpdateOrganizationJob).to receive(:perform_later).once.with(greenpeace)
      expect(UpdateOrganizationJob).to receive(:perform_later).once.with(i_wisth)

      subject
    end
  end
end
