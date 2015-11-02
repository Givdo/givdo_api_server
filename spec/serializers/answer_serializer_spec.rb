require 'rails_helper'

RSpec.describe TriviaSerializer, type: :serializer do
  let(:answer) { build(:answer, :correct => true) }

  subject { serialize(answer, AnswerSerializer) }

  it 'includes the correctness' do
    expect(subject[:correct]).to be true
  end
end
