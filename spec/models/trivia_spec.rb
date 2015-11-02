require 'rails_helper'

RSpec.describe Trivia, type: :model do
  describe "#answer!" do
    let(:user) { create(:user) }
    let(:trivia) { create(:trivia) }
    let(:option) { trivia.options.create }

    it 'creates an answer for the user with the given option' do
      answer = trivia.answer! user, option.id

      expect(answer.user).to eql user
      expect(answer.option).to eql option
      expect(answer).to be_persisted
      expect(answer).to be_a(Answer)
    end
  end
end
