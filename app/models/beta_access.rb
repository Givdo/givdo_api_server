# == Schema Information
#
# Table name: beta_accesses
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  granted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  email      :string
#
# Indexes
#
#  index_beta_accesses_on_email  (email) UNIQUE
#

class BetaAccess < ActiveRecord::Base
  belongs_to :user

  delegate :name, :to => :user, :prefix => true, :allow_nil => true
  delegate :image, :to => :user, :prefix => true, :allow_nil => true

  scope :awaiting, -> { where(granted_at: nil).where.not(user: nil) }
  scope :granted, -> { where.not(user: nil, granted_at: nil) }

  validates_uniqueness_of :email

  def self.user_beta_access(user)
    where(email: user.email).first_or_create do |beta_access|
      beta_access.user = user
    end
  end

  def self.granted?(user)
    user_beta_access(user).granted?
  end

  def self.grant!(user)
    user_beta_access(user).grant!
  end

  def granted?
    granted_at && granted_at <= DateTime.current
  end

  def grant!
    update_attribute(:granted_at, DateTime.current)
  end
end
