require 'rails_helper'

RSpec.describe GameInvite, :type => :model do
  let(:user) { build(:user) }
  let(:invite) { GameInvite.new(user, 'facebook', ['12345', '54321']) }

  describe '#invite!' do
    before { allow(User).to receive(:for_provider_batch!).and_return([]) }

    subject { invite.invite! }

    it { is_expected.to be_persisted }

    it 'creates a game with the user as its creator' do
      expect(subject.creator).to eql user
    end

    it 'includes the creator in the list of players' do
      expect(subject.players).to include user
    end

    it 'creates a user for unexisting users' do
      user1, user2 = build(:user), build(:user)

      expect(User).to receive(:for_provider_batch!).with('facebook', ['12345', '54321']).and_return([user1, user2])

      expect(subject.players).to include(user1, user2)
    end
  end
end
