class Officer < ApplicationRecord
  has_many :incidents, dependent: :destroy
end
