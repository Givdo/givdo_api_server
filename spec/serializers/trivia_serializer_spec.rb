require 'rails_helper'

RSpec.describe TriviaSerializer, type: :serializer do
  let!(:option) { trivia.options.build(text: 'lol') }
  let(:trivia) { build(:trivia, id: 46, question: 'My question') }
  subject { serialize(trivia, TriviaSerializer) }

  it 'includes the id' do
    expect(subject[:id]).to eql 46
  end

  it 'includes the question' do
    expect(subject[:question]).to eql 'My question'
  end

  it 'includes the options' do
    expect(subject[:options]).to serialize_collection(option).with(TriviaOptionSerializer)
  end
end
