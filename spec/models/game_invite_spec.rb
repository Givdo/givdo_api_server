require 'rails_helper'

RSpec.describe GameInvite, :type => :model do
  let(:user) { build(:user) }
  let(:invitee_user1) { build(:user) }
  let(:invitee_user2) { build(:user) }
  let(:game) { build(:game, :creator => user) }
  subject { GameInvite.new(game, 'facebook', ['12345', '54321']) }

  describe '#invite!' do
    before do
      user1, user2 = build(:user), build(:user)
      allow(User).to receive(:for_provider_batch!).
                        with('facebook', [{'id' => '12345'}, {'id' => '54321'}]).
                        and_return([invitee_user1, invitee_user2])
      subject.invite!
    end

    it 'includes the creator in the list of players' do
      expect(game.players.size).to eql(3)
      expect(game.users).to include user
    end

    it 'creates a user for unexisting users' do
      expect(game.users).to include(invitee_user1, invitee_user2)
    end
  end
end
