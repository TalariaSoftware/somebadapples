class Agency < ApplicationRecord
  validates :name, uniqueness: true

  has_many :positions, dependent: :destroy
  has_many :officers, through: :positions
end
