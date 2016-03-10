# == Schema Information
#
# Table name: categories
#
#  id   :integer          not null, primary key
#  name :string
#

class Category < ActiveRecord::Base
  has_many :trivias

  def self.other
    Category.find_or_create_by(name: 'Other')
  end
end
