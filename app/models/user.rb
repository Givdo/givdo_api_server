# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  provider        :string           not null
#  uid             :string           not null
#  name            :string
#  nickname        :string
#  image           :string
#  email           :string
#  created_at      :datetime
#  updated_at      :datetime
#  provider_token  :text
#  organization_id :integer
#  cover           :string
#
# Indexes
#
#  index_users_on_email             (email)
#  index_users_on_uid_and_provider  (uid,provider) UNIQUE
#

class User < ActiveRecord::Base
  validates :uid, :presence => :true
  validates :provider, :presence => :true

  belongs_to :organization
  has_many :players
  has_many :games, :through => :players
  has_many :owned_games, :class_name => 'Game', :foreign_key => :creator_id

  def self.for_provider!(provider, uid, params={})
    where(:uid => uid, :provider => provider).first_or_initialize.tap do |user|
      user.assign_attributes(params)
      user.save!
    end
  end

  def self.for_provider_batch!(provider, user_data=[])
    uids = user_data.map{|data| data['id']}
    existing_users = where(:provider => provider, :uid => uids).all
    uids_to_create = (uids - existing_users.map(&:uid))
    new_users = uids_to_create.map do |uid|
      extra_data = user_data.find{|data| data['id'].eql?(uid)} || {}
      {:provider => provider, :uid => uid}.merge(extra_data.slice('name', 'image'))
    end

    User.create(new_users) + existing_users
  end

  def current_single_game
    games.unfinished.single.last || owned_games.create
  end

  def current_game_versus(user)
    games.unfinished.versus(user).last || owned_games.create do |game|
      game.add_player(user)
    end
  end
end
