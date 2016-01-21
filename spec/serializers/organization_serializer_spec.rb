require 'rails_helper'

RSpec.describe OrganizationSerializer do
  let(:organization) do
    build(:organization, {
      :id => 10,
      :facebook_id => 123,
      :name => 'Save the NGOs Foundation',
      :picture => 'image.jpg',
      :state => 'CA',
      :city => 'San Francisco',
      :zip => '50000',
      :street => 'Mission Av',
      :mission => 'A world with lots of NGOs'
    })
  end
  subject { serialize(organization, OrganizationSerializer) }

  it 'includes the id' do
    expect(subject[:data][:id]).to eql '10'
  end

  it { is_expected.to serialize_attribute(:name).with('Save the NGOs Foundation') }
  it { is_expected.to serialize_attribute(:facebook_id).with('123') }
  it { is_expected.to serialize_attribute(:name).with('Save the NGOs Foundation') }
  it { is_expected.to serialize_attribute(:picture).with('image.jpg') }
  it { is_expected.to serialize_attribute(:state).with('CA') }
  it { is_expected.to serialize_attribute(:city).with('San Francisco') }
  it { is_expected.to serialize_attribute(:zip).with('50000') }
  it { is_expected.to serialize_attribute(:street).with('Mission Av') }
  it { is_expected.to serialize_attribute(:mission).with('A world with lots of NGOs') }
end
