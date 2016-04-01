# == Schema Information
#
# Table name: organizations
#
#  id          :integer          not null, primary key
#  facebook_id :string
#  name        :string
#  picture     :string
#  state       :string
#  city        :string
#  zip         :string
#  street      :string
#  mission     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  cached_at   :datetime
#

class Organization < ActiveRecord::Base
  has_many :players

  scope :cache_due, -> { where('cached_at < ? OR cached_at IS NULL', 10.days.ago) }

  def self.with_score
    joins(:players)
      .select('organizations.*, SUM(players.score) AS total_score')
      .merge(Player.finished)
      .group('organizations.id')
  end

  def self.scores_between(start_date, end_date)
    self.with_score
      .where('players.created_at BETWEEN ? AND ?', start_date, end_date)
  end

  def cache!
    self.cached_at = Time.current
  end

  def cached?
    !self.cached_at.nil?
  end
end
