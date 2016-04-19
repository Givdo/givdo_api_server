require 'rails_helper'

RSpec.describe GameSerializer, :type => :serializer do
  let(:game) { create(:game, :two_players) }
  let(:trivia) { create(:trivia) }
  before { allow(game).to receive(:next_trivia).with(game.creator).and_return(trivia) }
  subject { serialize(game, GameSerializer, :scope => game.creator, :include => 'player,trivia') }

  it { is_expected.to serialize_id_and_type(game.id.to_s, 'games') }
  it { is_expected.to serialize_link(:player).with(api_v1_game_player_url(game)) }
  it { is_expected.to serialize_link(:answers).with(api_v1_game_answers_url(game)) }

  it { is_expected.to serialize_included(game.player(game.creator)).with(PlayerSerializer) }
  it { is_expected.to serialize_included(trivia).with(TriviaSerializer) }
end
