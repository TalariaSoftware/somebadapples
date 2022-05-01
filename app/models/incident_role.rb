class IncidentRole < ApplicationRecord
  belongs_to :officer
  belongs_to :incident
end
