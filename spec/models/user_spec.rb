require 'rails_helper'

RSpec.describe User, :type => :model do
  it 'is not valid without the uid' do
    subject.uid = nil
    expect(subject).to_not be_valid
    expect(subject.errors[:uid]).to eql ['can\'t be blank']
  end

  it 'is not valid without the provider' do
    subject.provider = nil
    expect(subject).to_not be_valid
    expect(subject.errors[:provider]).to eql ['can\'t be blank']
  end

  describe '.for_provider!' do
    subject { User.for_provider!('facebook', 'facebook id', {:provider_token => 'token'}) }

    it 'is the existing user by the provider and provider id' do
      user = create(:user, {
        :provider => 'facebook',
        :uid => 'facebook id',
        :provider_token => 'old token'
      })

      expect(subject).to eql user
      expect(subject.provider_token).to eql 'token'
    end

    it 'is an initialized user with the provider and provider id if one does not exist' do
      User.where(:provider => 'facebook', :uid => 'facebook id').destroy_all

      expect(subject).to be_persisted
      expect(subject.provider).to eql 'facebook'
      expect(subject.uid).to eql 'facebook id'
      expect(subject.provider_token).to eql 'token'
    end
  end

  describe '.for_provider_batch!' do
    let(:user1) { User.create(:provider => 'facebook', :uid => 'existing-uid-1') }
    let(:user2) { User.create(:provider => 'facebook', :uid => 'existing-uid-2') }
    subject { User.for_provider_batch!('facebook', [{'id' => user1.uid}, {'id' => user2.uid}, {'id' => 'unexisting-user'}]) }

    it 'includes all existing users' do
      expect(subject).to include(user1, user2)
    end

    it 'creates a user for the unexisting uids' do
      user = subject.find {|u| u.uid.eql?('unexisting-user')}

      expect(user.provider).to eql 'facebook'
      expect(user).to be_persisted
    end

    context 'with extra data' do
      subject do
        User.for_provider_batch!('facebook', [
          {'id' => 'unexisting-user-1', 'name' => 'Hernando Herrera'},
          {'id' => 'unexisting-user-2', 'image' => 'http://www.givdo.com/image.jpg'}
        ])
      end

      it 'adds extra data when given to the user' do
        user = subject.find {|u| u.uid.eql?('unexisting-user-1')}

        expect(subject.map(&:name)).to match_array ['Hernando Herrera', nil]
        expect(subject.map(&:image)).to match_array [nil, 'http://www.givdo.com/image.jpg']
      end
    end
  end

  describe '#current_single_game' do
    let(:finished_game) { double('finished game', :finished? => true) }
    let(:unfinished_games) { double }
    before { allow(subject.games).to receive(:unfinished).and_return unfinished_games }
    subject { create(:user) }

    it 'is the last single game when it is not yet unfinished' do
      open_game = double('unfinished game', :finished? => false)

      allow(unfinished_games).to receive(:single).and_return([open_game])

      expect(subject.current_single_game).to be open_game
    end

    it 'is a new game when user has no unfinished single games' do
      new_game = double('new game')

      allow(unfinished_games).to receive(:single).and_return([])
      expect(subject.owned_games).to receive(:create).and_return(new_game)

      expect(subject.current_single_game).to be new_game
    end
  end

  describe '#current_game_versus' do
    let(:new_game) { double('new game') }
    let(:open_game) { double('unfinished game', :finished? => false) }
    let(:finished_game) { double('finished game', :finished? => true) }
    let(:friend) { create(:user) }
    let(:user) { create(:user) }
    let(:unfinished_games) { double }
    before { allow(user.games).to receive(:unfinished).and_return unfinished_games }
    subject { user.current_game_versus(friend) }

    it 'is the last game versus the friend' do
      allow(unfinished_games).to receive(:versus).with(friend).and_return([open_game])

      expect(subject).to be open_game
    end

    it 'is a new game when there are no unfinished games' do
      allow(unfinished_games).to receive(:versus).with(friend).and_return([])

      expect(subject).to be_a Game
    end

    it 'includes the friend user as a player' do
      allow(unfinished_games).to receive(:versus).with(friend).and_return([])

      expect(subject.players.pluck(:user_id)).to match_array [user.id, friend.id]
    end
  end
end
