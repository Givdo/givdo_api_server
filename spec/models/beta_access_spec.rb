require 'rails_helper'

RSpec.describe BetaAccess, :type => :model do
  let(:user) { create(:user, :provider => 'facebook', :uid => '123456') }

  describe 'scopes' do
    let!(:granted) { create(:beta_access, :granted_at => 1.day.ago) }
    let!(:awaiting) { create(:beta_access, :granted_at => nil) }

    describe '.awaiting' do
      it 'is the collection of beta access request awaiting to be granted' do
        expect(BetaAccess.awaiting.pluck(:id)).to match_array [awaiting.id]
      end
    end

    describe '.granted' do
      it 'is the collection of beta access requests granted' do
        expect(BetaAccess.granted.pluck(:id)).to match_array [granted.id]
      end
    end
  end

  describe '.granted?' do
    it 'is granted when the provider/uid pair have been granted beta access' do
      BetaAccess.create(:user => user).grant!

      expect(BetaAccess).to be_granted(user)
    end

    it 'is not granted when the provider/uid pair have not been granted beta access' do
      BetaAccess.destroy_all(:user => user)

      expect(BetaAccess).to_not be_granted(user)
    end

    it 'is not granted when the provider/uid pair have requested beta access' do
      BetaAccess.create(:user => user)

      expect(BetaAccess).to_not be_granted(user)
    end

    it 'creates a beta access if one does not exist' do
      BetaAccess.destroy_all(:user => user)

      expect { BetaAccess.granted?(user) }.to change { BetaAccess.where(:user => user).count }.by(1)
    end
  end

  describe '.grant!' do
    it 'grants access to the user' do
      BetaAccess.grant! user

      expect(BetaAccess).to be_granted(user)
    end
  end
end
