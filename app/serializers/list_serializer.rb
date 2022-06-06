class ListSerializer < ActiveModel::Serializer
  attributes %i[id user_id title recommend playlistid comments_count]
  has_many :videos
  has_many :tags
  has_one :user

  class VideoSerializer < ActiveModel::Serializer
    attributes %i[id videoid]
  end

  class TagSerializer < ActiveModel::Serializer
    attributes %i[id name]
  end

  class UserSerializer < ActiveModel::Serializer
    attributes %i[name profile avatar_url]
  end

  def comments_count
    Comment.where(list: object).count
  end
end
