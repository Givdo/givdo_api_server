require 'rails_helper'

RSpec.describe GameSerializer, :type => :serializer do
  let(:game) { build(:game, :id => 10) }
  let(:user) { build(:user) }
  let(:player) { build(:player, :id => 20) }
  let(:trivia) { build(:trivia, :id => 30) }
  before { allow(TriviaRaffle).to receive(:next).with(user, game).and_return(trivia) }
  before { allow(game).to receive(:player).with(user).and_return(player) }
  subject { serialize(game, GameSerializer, :scope => user, :include => 'player,trivia') }

  it { is_expected.to serialize_id_and_type('10', 'games') }
  it { is_expected.to serialize_link(:player).with(game_player_url(game)) }
  it { is_expected.to serialize_link(:answers).with(game_answers_url(game)) }

  it { is_expected.to serialize_included(player).with(PlayerSerializer) }
  it { is_expected.to serialize_included(trivia).with(TriviaSerializer) }
end
