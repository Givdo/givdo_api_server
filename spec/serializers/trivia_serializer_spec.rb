require 'rails_helper'

RSpec.describe TriviaSerializer, type: :serializer do
  let!(:option) { trivia.options.build(text: 'lol') }
  let(:trivia) { build(:trivia, id: 46, question: 'My question') }
  subject { serialize(trivia, TriviaSerializer, :include => 'options') }

  it { is_expected.to serialize_id_and_type('46', 'trivia') }
  it { is_expected.to serialize_attribute(:question).with('My question') }

  it { is_expected.to serialize_included(option).with(TriviaOptionSerializer) }
end
