require 'rails_helper'

RSpec.describe TriviaOptionSerializer, type: :serializer do
  let(:option) { build(:trivia_option, text: 'text', id: 15) }
  subject { serialize(option, TriviaOptionSerializer) }

  it 'includes the id' do
    expect(subject[:id]).to eql 15
  end

  it 'includes the text' do
    expect(subject[:text]).to eql 'text'
  end
end
