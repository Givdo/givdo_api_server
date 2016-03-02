require 'rails_helper'

RSpec.describe PlayerSerializer, :type => :serializer do
  let(:organization) { build(:organization, :name => 'Save Dave') }
  let(:user) { build(:user, :name => 'John Doe', :image => 'ugly-picture.jpg') }
  let(:player) { build(:player, :organization => organization, :user => user, :finished_at => DateTime.current, :score => 5) }
  before { allow(player).to receive(:rounds_left).and_return(5) }
  before { allow(player).to receive(:winner?).and_return(true) }
  subject { serialize(player, PlayerSerializer, :include => 'organization') }

  it { is_expected.to serialize_attribute(:rounds_left).with(5) }
  it { is_expected.to serialize_attribute(:organization).with('Save Dave') }
  it { is_expected.to serialize_attribute(:finished?).with(true) }
  it { is_expected.to serialize_attribute(:name).with('John Doe') }
  it { is_expected.to serialize_attribute(:image).with('ugly-picture.jpg') }
  it { is_expected.to serialize_attribute(:score).with(5) }
  it { is_expected.to serialize_attribute(:winner?).with(true) }
  it { is_expected.to serialize_included(organization).with(OrganizationSerializer) }
end
