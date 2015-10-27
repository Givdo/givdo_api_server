class Organization < ActiveRecord::Base
  def cache!
    self.cached_at = Time.current
  end

  def cached?
    !self.cached_at.nil?
  end
end
