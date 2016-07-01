require 'rails_helper'

RSpec.describe Givdo::TriviaImporter do
  subject(:importer) { described_class }

  let(:sheet) { double(:sheet) }
  let(:attrs) {
    {
      question: 'Guess the number?',
      correct_option: '1',
      option_1: '2',
      option_2: '3',
      tag: 'General',
    }
  }

  it "skips the header row" do
    allow(sheet).to receive(:each_with_index).and_yield({}, 0)

    expect(Trivia).not_to receive(:find_or_create_by!)
  end

  it "saves trivias without duplication" do
    allow(sheet).to receive(:each_with_index).and_yield(attrs, 1).and_yield(attrs, 2)

    expect{ importer.import!(sheet) }.to change{ Trivia.count }.by(1)
  end

  it "saves trivia's options" do
    allow(sheet).to receive(:each_with_index).and_yield(attrs, 1)

    trivia = importer.import!(sheet)
    correct_option = trivia.correct_option
    options_text = trivia.options.pluck(:text)

    expect(correct_option.text).to eq(attrs[:correct_option])
    expect(options_text).to include(attrs[:option_1], attrs[:option_2])
  end
end
