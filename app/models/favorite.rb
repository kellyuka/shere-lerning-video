class Favorite < ApplicationRecord
  belongs_to :list
  belongs_to :user

  validates :user_id, uniqueness: { scope: :list_id }
end
