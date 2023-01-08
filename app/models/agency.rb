class Agency < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, uniqueness: true

  has_many :positions, dependent: :destroy
  has_many :officers, through: :positions
end
