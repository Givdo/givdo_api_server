class FriendsListSerializer < ActiveModel::Serializer
  has_many :list
  attribute :next_page

  def next_page
    object.next_page_params
  end
end
