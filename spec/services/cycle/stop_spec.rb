require 'rails_helper'

RSpec.describe Cycle::Stop do
  subject(:service) { described_class }

  it "stops the current cycle" do
    cycle = build(:cycle, ended_at: nil)
    allow(Cycle::CreateScores).to receive(:call).with(cycle)

    expect(cycle).to receive(:stop!)

    service.call(cycle)
  end

  it "creates scores for the stoped cycle" do
    cycle = build(:cycle, ended_at: nil)

    expect(Cycle::CreateScores).to receive(:call).with(cycle)

    service.call(cycle)
  end
end
