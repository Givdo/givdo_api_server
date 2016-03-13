require 'rails_helper'

RSpec.describe Match, :type => :model do
  let(:unknown_user) { create(:user) }
  let(:friend) { create(:user) }
  let(:user) { create(:user) }
  let(:finished_versus) do
    user.owned_games.create(:rounds => 0, :users => [friend]).tap do |game|
      game.players.each(&:finish!)
    end
  end
  let(:finished_single) do
    user.owned_games.create(:rounds => 0).tap do |game|
      game.players.each(&:finish!)
    end
  end
  let(:unrelated_versus) { user.owned_games.create(:rounds => 1, :users => [unknown_user]) }
  let(:unrelated_single) { unknown_user.owned_games.create(:rounds => 1) }
  let(:open_versus) { user.owned_games.create(:rounds => 1, :users => [friend]) }
  let(:open_single) { user.owned_games.create(:rounds => 1) }

  describe '#current' do
    subject { match.current }

    context 'versus someone' do
      let(:match) { Match.new(user, friend) }

      it 'is the latest open game among the users' do
        open_versus; finished_versus; finished_single; unrelated_versus

        expect(subject).to eql open_versus
      end

      it 'adds the versus player when creating the game' do
        expect(subject.players.map(&:user)).to match_array [user, friend]
      end
    end

    context 'single' do
      let(:match) { Match.new(user) }

      it 'is the latest open single game' do
        open_single; finished_versus; finished_single; unrelated_versus

        expect(subject).to eql open_single
      end

      it 'has only one player when creating a new game' do
        expect(subject.players.map(&:user)).to match_array [user]
      end
    end
  end
end
