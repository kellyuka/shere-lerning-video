class User < ApplicationRecord
  include JwtToken
  authenticates_with_sorcery!

  has_many :lists, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar
  has_many :favorites, dependent: :destroy
  has_many :favorites_lists, through: :favorites, source: :list

  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true
  def avatar_url
    avatar.attached? ? Rails.application.routes.url_helpers.rails_blob_path(avatar, only_path: true) : nil
  end

  def favorite(list)
    favorites_lists << list
  end

  def unfavorite(list)
    favorites_lists.destroy(list)
  end
end
