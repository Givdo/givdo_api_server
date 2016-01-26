require 'rails_helper'

RSpec.describe Player, :type => :model do
  describe '#rounds_left' do
    it 'is the number of rounds a game allows minus the number of rounds the player have played' do
      subject.game = build(:game, :rounds => 5)
      subject.answers << build(:answer) << build(:answer)
      subject.save

      expect(subject.rounds_left).to eql 3
    end
  end

  describe '#finish!' do
    it 'updates the finished at timestamp' do
      Timecop.freeze(frozen_time = Time.utc(2016, 01, 30, 20, 0, 0))
      player = create(:player)

      player.finish!

      expect(player.finished_at.to_s).to eql frozen_time.utc.to_s
    end
  end

  describe '#answer!' do
    let(:player) { create(:player) }
    let(:trivia) { create(:trivia, :with_options)}
    let(:game) { player.game }
    subject! do
      game.update_attribute(:rounds, 1)
      player.answer!({
        :trivia_id => trivia.id,
        :trivia_option_id => trivia.correct_option_id
      })
    end

    it 'finishes the player participation when answers reach the rounds limit' do
      expect(player.finished_at).to_not be_nil
    end

    it 'answers with the given user' do
      expect(subject.player).to eql player
    end

    it 'answers with the trivia and option' do
      expect(subject.trivia).to eql trivia
    end

    it 'answers with the trivia and option' do
      expect(subject.trivia_option).to eql trivia.correct_option
    end
  end

  describe '#has_rounds?' do
    let(:trivia1) { create(:trivia, :with_options) }
    let(:trivia2) { create(:trivia, :with_options) }
    let(:trivia3) { create(:trivia, :with_options) }
    let(:user) { create(:user) }
    let(:game) { create(:game, :creator => user, :rounds => 2) }
    let(:player) { game.player(user) }

    it 'has rounds when the number of answers is less than the number of rounds' do
      game.answer!(user, {:trivia => trivia1, :trivia_option => trivia1.correct_option})

      expect(player).to have_rounds
    end

    it 'does not have rounds when the number of answers is equal to the number of rounds' do
      game.answer!(user, {:trivia => trivia1, :trivia_option => trivia1.correct_option})
      game.answer!(user, {:trivia => trivia2, :trivia_option => trivia2.correct_option})

      expect(player).to_not have_rounds
    end

    it 'does not have rounds when the number of answers is over the number of rounds' do
      game.answer!(user, {:trivia => trivia1, :trivia_option => trivia1.correct_option})
      game.answer!(user, {:trivia => trivia2, :trivia_option => trivia2.correct_option})
      game.answer!(user, {:trivia => trivia2, :trivia_option => trivia3.correct_option})

      expect(player).to_not have_rounds
    end
  end
end
