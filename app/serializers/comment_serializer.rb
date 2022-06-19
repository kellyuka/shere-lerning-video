class CommentSerializer < ActiveModel::Serializer
  attributes %i[id body user_id]
  has_one :user

  class UserSerializer < ActiveModel::Serializer
    attributes %i[name avatar_url]
  end
end
