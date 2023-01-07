class Agency < ApplicationRecord
  validates :name, uniqueness: true
end
