require 'rails_helper'

RSpec.describe Cycle::Start do
  subject(:service) { described_class }

  it "stops the current cycle if it exists" do
    current_cycle = build(:cycle, ended_at: nil)
    allow(Cycle).to receive(:current).and_return(current_cycle)

    expect(Cycle::Stop).to receive(:call).with(current_cycle)

    service.call
  end

  it "creates a new cycle" do
    allow(Cycle::Stop).to receive(:call)

    expect(Cycle).to receive(:create!)

    service.call
  end

  it "returns a cycle" do
    cycle = build(:cycle)
    allow(Cycle::Stop).to receive(:call)
    allow(Cycle).to receive(:create!).and_return(cycle)

    expect(service.call).to eq(cycle)
  end
end
