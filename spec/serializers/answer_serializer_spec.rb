require 'rails_helper'

RSpec.describe TriviaSerializer, type: :serializer do
  let(:trivia) { build(:trivia, :with_options, :correct_option_id => 15) }
  let(:answer) { build(:answer, :correct => true, :option => trivia.options.first) }

  subject { serialize(answer, AnswerSerializer) }

  it 'includes the correctness of the answer' do
    expect(subject[:correct]).to be true
  end

  it 'includes the correct option id' do
    expect(subject[:correct_option_id]).to eql 15
  end
end
