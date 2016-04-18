require 'rails_helper'

RSpec.describe User::AssignBadges, type: :service do
  subject(:service) { described_class }

  it "adds badges to the user" do
    user = double(User)
    badges = build_stubbed_list(:badge, 3)
    allow(Badge).to receive(:next_badges_for).with(user).and_return(badges)

    expect(user).to receive(:add_badges)

    service.call(user)
  end
end
