class Position < ApplicationRecord
  belongs_to :agency
  belongs_to :officer

  delegate :name, to: :agency, prefix: true
end
