require 'rails_helper'

RSpec.describe Trivia, type: :model do
  subject(:trivia) { described_class.new }

  describe ".new_option" do
    let(:attrs) { { text: 'Some text' } }

    it "returns a trivia option" do
      option = trivia.new_option(attrs)

      expect(option).to be_a TriviaOption
    end

    it "assigns trivia to itself" do
      option = trivia.new_option(attrs)

      expect(option.trivia).to eq(trivia)
    end
  end

  describe ".new_correct_option" do
    let(:attrs) { { text: 'Some text' } }

    it "returns a trivia option" do
      option = trivia.new_correct_option(attrs)

      expect(option).to be_a TriviaOption
    end

    it "assigns trivia to itself" do
      option = trivia.new_correct_option(attrs)

      expect(option.trivia).to eq(trivia)
    end

    it "assigns trivia's correct option" do
      option = trivia.new_correct_option(attrs)

      expect(trivia.correct_option).to eq(option)
    end
  end
end
