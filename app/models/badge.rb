# == Schema Information
#
# Table name: badges
#
#  id         :integer          not null, primary key
#  name       :string
#  score      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_badges_on_score  (score)
#

class Badge < ActiveRecord::Base
  has_and_belongs_to_many :users

  def self.next_badges_for(user)
    where('badges.score <= ?', user.total_score).where.not(id: user.badges)
  end
end
