class Tag < ApplicationRecord
  has_many :list_tags
  has_many :lists, through: :list_tags
end
