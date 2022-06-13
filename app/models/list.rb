class List < ApplicationRecord
  include JwtToken
  authenticates_with_sorcery!
  belongs_to :user
  has_many :videos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :list_tags, dependent: :destroy
  has_many :tags, through: :list_tags
  has_many :favorites, dependent: :destroy
end
