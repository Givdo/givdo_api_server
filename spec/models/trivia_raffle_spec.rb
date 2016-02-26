require 'rails_helper'

describe TriviaRaffle do
  let!(:trivia1) { create(:trivia, :question => 'trivia 1') }
  let!(:trivia2) { create(:trivia, :question => 'trivia 2') }
  let!(:trivia3) { create(:trivia, :question => 'trivia 3') }
  let(:game) { build(:game, :trivias => [trivia1]) }
  subject { TriviaRaffle.new(game, 2) }

  describe ".raffle" do
    it 'is the `limit` of trivias not currently used in the game' do
      expect(subject.raffle.pluck(:question)).to match_array ['trivia 2', 'trivia 3']
    end
  end
end
