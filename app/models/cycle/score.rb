# == Schema Information
#
# Table name: cycle_scores
#
#  id              :integer          not null, primary key
#  score           :integer
#  cycle_id        :integer
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_cycle_scores_on_cycle_id         (cycle_id)
#  index_cycle_scores_on_organization_id  (organization_id)
#

class Cycle::Score < ActiveRecord::Base
  belongs_to :cycleg
  belongs_to :organization
end
