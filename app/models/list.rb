class List < ApplicationRecord
  include JwtToken
  authenticates_with_sorcery!
  belongs_to :user
  has_many :videos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :list_tags, dependent: :destroy
  has_many :tags, through: :list_tags
  has_many :favorites, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
  validates :recommend, length: { maximum: 1000 }
  validates :playlistid, presence: true
end
