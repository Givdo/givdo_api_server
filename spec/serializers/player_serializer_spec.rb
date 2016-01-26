require 'rails_helper'

RSpec.describe PlayerSerializer, :type => :serializer do
  let(:organization) { build(:organization, :name => 'Save Dave') }
  let(:player) { build(:player, :organization => organization, :finished_at => DateTime.current) }
  before { allow(player).to receive(:rounds_left).and_return(5) }
  before { allow(player).to receive(:score).and_return(3) }
  subject { serialize(player, PlayerSerializer) }

  it { is_expected.to serialize_attribute(:rounds_left).with(5) }
  it { is_expected.to serialize_attribute(:organization).with('Save Dave') }
  it { is_expected.to serialize_attribute(:score).with(3) }
  it { is_expected.to serialize_attribute(:finished?).with(true) }
end
