class UserSerializer < ActiveModel::Serializer
  attributes %i[id email name profile channelid avatar_url]
end
