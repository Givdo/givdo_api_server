require 'rails_helper'

RSpec.describe Player, :type => :model do
  describe '#rounds_left' do
    it 'is the number of rounds left for the user in the game' do
      user = build(:user)
      game = build(:game)
      subject.game = game
      subject.user = user

      expect(game).to receive(:rounds_left).with(user).and_return(5)

      expect(subject.rounds_left).to eql 5
    end
  end
end
