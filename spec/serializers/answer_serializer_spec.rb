require 'rails_helper'

RSpec.describe AnswerSerializer, :type => :serializer do
  let(:player) { build(:player, :id => 10) }
  let(:game) { player.game }
  let(:trivia) { build(:trivia, :with_options, :correct_option_id => 15) }
  let(:answer) { build(:answer, :correct => true, :trivia => trivia, :player => player) }

  subject { serialize(answer, AnswerSerializer, :scope => game.creator, :include => 'game,player') }

  it { is_expected.to serialize_attribute(:correct).with(true) }
  it { is_expected.to serialize_attribute(:correct_option_id).with(15) }

  it { is_expected.to serialize_included(game).with(GameSerializer, :scope => game.creator) }
  it { is_expected.to serialize_included(player).with(PlayerSerializer) }
end
