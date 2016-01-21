require 'rails_helper'

RSpec.describe PlayerSerializer, :type => :serializer do
  let(:organization) { build(:organization, :name => 'Save Dave') }
  let(:player) { build(:player, :organization => organization) }
  before { allow(player).to receive(:rounds_left).and_return(5) }
  subject { serialize(player, PlayerSerializer) }

  it { is_expected.to serialize_attribute(:rounds_left).with(5) }
  it { is_expected.to serialize_attribute(:organization).with('Save Dave') }
end
