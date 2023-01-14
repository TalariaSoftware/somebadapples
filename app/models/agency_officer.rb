class AgencyOfficer < ApplicationRecord
  belongs_to :agency
  belongs_to :officer

  self.table_name = :agencies_officers

  def readonly?
    true
  end
end
