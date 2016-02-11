require 'rails_helper'

RSpec.describe BetaAccess, :type => :model do
  let(:user) { create(:user, :provider => 'facebook', :uid => '123456') }

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
  end
end
