require 'rails_helper'

RSpec.describe GameInvite, :type => :model do
  let(:user) { User.new }
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
      user_12345, user_54321 = User.new(uid: '12345'), User.new(uid: '54321')

      expect(User).to receive(:for_provider_batch!).with('facebook', ['12345', '54321']).and_return([user_12345, user_54321])

      expect(subject.players).to include(user_12345, user_54321)
    end
  end
end
