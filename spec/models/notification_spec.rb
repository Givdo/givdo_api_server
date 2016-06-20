require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "#reject!" do
    it "marks the notification as rejected" do
      notification = build(:notification, status: :not_answered)

      notification.reject!

      expect(notification.reload).to be_rejected
    end
  end

  describe "#accept!" do
    it "marks the notification as accepted" do
      notification = build(:notification, status: :not_answered)

      notification.accept!

      expect(notification.reload).to be_accepted
    end
  end
end
