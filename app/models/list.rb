class List < ApplicationRecord
  include JwtToken
  authenticates_with_sorcery!
  belongs_to :user
  has_many :videos, dependent: :destroy
end
