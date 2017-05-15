# == Schema Information
#
# Table name: advertisements
#
#  id                 :integer          not null, primary key
#  company_name       :string
#  image              :string
#  link               :string
#  impressions        :integer          default(0)
#  clicks             :integer          default(0)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  default            :boolean          default(FALSE)
#  active             :boolean          default(TRUE)
#

class Advertisement < ActiveRecord::Base
  with_options presence: true do
    validates :company_name
    validates :image
    validates :link
  end

  has_and_belongs_to_many :users

  has_attached_file :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  scope :default, -> { where(default: true) }
  scope :active, -> { where(active: true) }

  def add_click!
    self.clicks += 1
    save!
  end

  def add_impression!
    self.impressions += 1
    save!
  end

  def image_url
    image.url
  end
end
