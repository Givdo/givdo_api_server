require 'rails_helper'

RSpec.describe AnswerSerializer, :type => :serializer do
  let(:game) { build(:game, :id => 10) }
  let(:trivia) { build(:trivia, :with_options, :correct_option_id => 15) }
  let(:answer) { build(:answer, :correct => true, :trivia => trivia, :game => game) }

  subject { serialize(answer, AnswerSerializer, :include => 'game') }

  it { is_expected.to serialize_attribute(:correct).with(true) }
  it { is_expected.to serialize_attribute(:correct_option_id).with(15) }

  it { is_expected.to serialize_included(game).with(GameSerializer) }
end
