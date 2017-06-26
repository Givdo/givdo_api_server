require 'rails_helper'

RSpec.describe TriviaOptionSerializer, type: :serializer do
  let(:option) { build(:trivia_option, text: 'text', id: 15) }
  subject { serialize(option, TriviaOptionSerializer) }

  it { is_expected.to serialize_id_and_type('15', 'triviaOptions') }
  it { is_expected.to serialize_attribute(:text).with('text') }
end
