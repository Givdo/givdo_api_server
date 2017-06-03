require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'scopes' do
    describe '#unread' do
      it 'returns only unread notifications' do
        read_notifications = create_list(:notification, 2, read: true)
        unread_notifications = create_list(:notification, 2, read: false)

        expect(described_class.unread.size).to eq 2
        expect(described_class.unread).to include(*unread_notifications)
        expect(described_class.unread).not_to include(*read_notifications)
      end
    end
  end

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
