# == Schema Information
#
# Table name: cycles
#
#  id         :integer          not null, primary key
#  ended_at   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cycle < ActiveRecord::Base
  has_many :scores, class_name: 'Cycle::Score'

  scope :ended, -> { where.not(ended_at: nil) }

  def self.current
    where(ended_at: nil).last
  end

  def stop!
    update_attribute(:ended_at, Time.current)
  end

  def score
    scores.sum(:score)
  end

  def stoped?
    ended_at.present?
  end

  def started?
    !stoped?
  end
end
