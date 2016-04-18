require 'rails_helper'

RSpec.describe Player::Finish, type: :service do
  subject(:service) { described_class }

  it "finishes the player" do
    user = build(:user)
    player = double(Player, user: user)
    allow(Player::SaveActivity).to receive(:call)

    expect(player).to receive(:finish!)

    service.call(player)
  end

  it "saves user activity" do
    user = build(:user)
    player = double(Player, user: user)
    allow(player).to receive(:finish!).and_return(player)

    expect(Player::SaveActivity).to receive(:call).with(player)

    service.call(player)
  end

  it "assigns user badges" do
    user = build(:user)
    player = double(Player, user: user)
    allow(player).to receive(:finish!).and_return(player)
    allow(Player::SaveActivity).to receive(:call)

    expect(User::AssignBadges).to receive(:call).with(user)

    service.call(player)
  end
end
