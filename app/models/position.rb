class Position < ApplicationRecord
  belongs_to :agency
  belongs_to :officer
end
