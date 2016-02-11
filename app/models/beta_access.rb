# == Schema Information
#
# Table name: beta_accesses
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  granted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BetaAccess < ActiveRecord::Base
  belongs_to :user

  def self.granted?(user)
    where(:user => user).first.try(:granted?)
  end

  def granted?
    granted_at && granted_at <= DateTime.current
  end

  def grant!
    update_attribute(:granted_at, DateTime.current)
  end
end
