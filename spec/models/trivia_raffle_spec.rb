require 'rails_helper'

describe TriviaRaffle do
  let(:other) { Category.other }
  let(:environmental) { create(:category, :name => 'Environment') }
  let!(:environmental_trivia) { create(:trivia, :question => 'environmental trivia', :category => environmental) }
  let!(:other_trivia1) { create(:trivia, :category => other, :question => 'trivia 1') }
  let!(:other_trivia2) { create(:trivia, :category => other, :question => 'trivia 2') }
  let!(:other_trivia3) { create(:trivia, :category => other, :question => 'trivia 3') }
  let(:game) { build(:game, :trivias => [other_trivia1], :category => other) }
  subject { TriviaRaffle.new(game, 2) }

  describe ".raffle" do
    it 'is the `limit` of trivias not currently used in the game' do
      expect(subject.raffle.pluck(:question)).to match_array ['trivia 2', 'trivia 3']
    end

    it 'finds only trivias of the same category' do
      game.category = environmental

      expect(subject.raffle.pluck(:question)).to match_array ['environmental trivia']
    end
  end
end
