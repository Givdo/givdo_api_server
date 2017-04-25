# == Schema Information
#
# Table name: advertisements
#
#  id           :integer          not null, primary key
#  company_name :string
#  image        :string
#  link         :string
#  impressions  :integer          default(0)
#  clicks       :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Advertisement < ActiveRecord::Base
  with_options presence: true do
    validates :company_name
    validates :image
    validates :link
  end
end
