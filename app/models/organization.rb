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
  scope :not_cached, -> { where(cached_at: nil) }

  def cache!
    self.cached_at = Time.current
  end

  def cached?
    !self.cached_at.nil?
  end
end
