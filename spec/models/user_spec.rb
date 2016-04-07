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

  describe "#recent_activities" do
    it "returns only the requested number of activities" do
      user = create(:user_with_activities)

      recent_activities = user.recent_activities(2)

      expect(recent_activities.size).to eq(2)
    end

    it "orders activities in descending order" do
      user = create(:user)
      older_activity = create(:activity, user: user, created_at: 2.days.ago)
      recent_activity = create(:activity, user: user, created_at: 1.day.ago)

      recent_activities = user.recent_activities(2)

      expect(recent_activities.first).to eq(recent_activity)
      expect(recent_activities.last).to eq(older_activity)
    end
  end
end
