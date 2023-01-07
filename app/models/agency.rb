class Agency < ApplicationRecord
  validates_uniqueness_of :name
end
