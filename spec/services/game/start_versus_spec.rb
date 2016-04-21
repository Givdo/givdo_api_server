require 'rails_helper'

RSpec.describe Game::StartVersus do
  subject(:service) { described_class }

  it "creates a game where player 1 vs player 2" do
    game = double(Game)
    player_1 = double(User)
    player_2 = double(User)
    allow(player_1).to receive(:can_create_game?).and_return(true)

    expect(player_1).to receive(:create_game_versus!).with(player_2)

    service.call(player_1, player_2)
  end

  context "while in beta" do
    it "doesn't let the user create more than 10 games" do
      game = double(Game)
      player_1 = double(User)
      player_2 = double(User)

      expect(player_1).to receive(:can_create_game?)

      expect { service.call(player_1, player_2) }.to raise_exception(Givdo::Error)
    end
  end
end
