require 'rails_helper'

RSpec.describe Trivia, type: :model do
  describe "#answer!" do
    let(:user) { create(:user) }
    let(:trivia) { create(:trivia) }
    let(:option) { trivia.options.create }

    subject { answer = trivia.answer!(user, option.id) }

    it 'creates an answer for the user with the given option' do
      expect(subject.user).to eql user
      expect(subject.option).to eql option
      expect(subject).to be_persisted
      expect(subject).to be_a(Answer)
    end

    it 'marks the answer as correct when it is the correct option' do
      trivia.correct_option_id = option.id

      expect(subject).to be_correct
    end

    it 'marks the answer as incorrect when it is not the correct option' do
      trivia.correct_option_id = option.id + 10

      expect(subject).to_not be_correct
    end
  end
end
