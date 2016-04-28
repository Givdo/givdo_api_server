require 'rails_helper'


RSpec.describe Game::StartSingle, type: :service do
  subject(:service) { described_class }

  it "creates a single game for the user" do
    user = double(User)
    allow(user).to receive(:can_create_game?).and_return(true)

    expect(user).to receive(:create_single_game!)

    service.call(user)
  end

  context "while in beta" do
    it "doesn't let the user create more than 10 games" do
      user = double(User)
      allow(user).to receive(:can_create_game?).and_return(false)

      expect { service.call(user) }.to raise_exception(Givdo::Exceptions::GamesQuotaExeeded)
    end
  end
end
