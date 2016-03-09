require 'rails_helper'

RSpec.describe UpdateOrganizationJob, type: :job do
  let(:organization) { Organization.new(facebook_id: 'facebook id') }
  let(:graph) { double(:get_object => {}, :get_picture => nil) }
  before { allow(Givdo::Facebook).to receive(:graph).and_return(graph) }

  describe 'facebook error' do
    let(:error) { Koala::Facebook::ClientError.new(nil, nil) }
    before { allow(graph).to receive(:get_object).and_raise error }

    it 'logs and ignore the error' do
      expect(subject.logger).to receive(:error).with(error)

      subject.perform(organization)
    end
  end

  describe "organization data update" do
    let(:facebook_data) do
      {
        'name' => 'Rainforest Foundation',
        'mission' => 'Save the rainforest'
      }
    end
    before { allow(graph).to receive(:get_object).with('facebook id', fields: [:mission, :location]).and_return(facebook_data) }

    it 'saves the cached organization' do
      subject.perform(organization)

      expect(organization).to be_persisted
      expect(organization).to be_cached
    end

    it 'saves the organization info' do
      subject.perform(organization)

      expect(organization.name).to eql 'Rainforest Foundation'
      expect(organization.mission).to eql 'Save the rainforest'
    end

    context 'when it has location data' do
      it 'saves it' do
        facebook_data['location'] = {
          'city' => 'Brooklyn',
          'state' => 'NY',
          'zip' => '11238'
        }

        subject.perform(organization)

        expect(organization.city).to eql 'Brooklyn'
        expect(organization.state).to eql 'NY'
        expect(organization.zip).to eql '11238'
      end
    end

    context 'when it does not have location data' do
      it 'ignores it' do
        facebook_data.delete('location')

        organization.zip = '42420'
        organization.city = 'Old City'
        organization.state = 'OS'

        subject.perform(organization)

        expect(organization.zip).to eql '42420'
        expect(organization.city).to eql 'Old City'
        expect(organization.state).to eql 'OS'
      end
    end
  end

  it 'updates the organization picture' do
    allow(Givdo::Facebook.graph).to receive(:get_picture).with('facebook id', {type: 'large'}).and_return('image url')

    subject.perform(organization)

    expect(organization.picture).to eql 'image url'
  end
end
