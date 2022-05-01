class Tag < ApplicationRecord
  has_many :list_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :lists, through: :list_tags
end
