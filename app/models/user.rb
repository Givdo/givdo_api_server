# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  provider       :string           default("email"), not null
#  uid            :string           default(""), not null
#  name           :string
#  nickname       :string
#  image          :string
#  email          :string
#  created_at     :datetime
#  updated_at     :datetime
#  provider_token :text
#
# Indexes
#
#  index_users_on_email             (email)
#  index_users_on_uid_and_provider  (uid,provider) UNIQUE
#

class User < ActiveRecord::Base
  has_many :answers

  serialize :provider_token

  def self.for_provider(provider, uid, access_token)
    where(:uid => uid, :provider => provider).first_or_initialize.tap do |user|
      user.provider_token = access_token
    end
  end

  def provider_access_token
    provider_token.try(:fetch, 'token')
  end
end
