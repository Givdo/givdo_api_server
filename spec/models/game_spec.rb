require 'rails_helper'

RSpec.describe Game, :type => :model do
  let(:user) { create(:user) }
  let(:game) { Game.create(creator: user) }

  it 'includes the creator in the players list' do
    expect(game.users).to match_array [user]
  end

  describe '#answer!' do
    let(:trivia) { create(:trivia, :with_options) }

    subject do
      game.answer!(user, {
        :trivia_id => trivia.id,
        :option_id => trivia.correct_option_id
      })
    end

    it 'answers with the given user' do
      expect(subject.user).to eql user
    end

    it 'answers with the trivia and option' do
      expect(subject.trivia).to eql trivia
    end

    it 'answers with the trivia and option' do
      expect(subject.option).to eql trivia.correct_option
    end
  end
end
