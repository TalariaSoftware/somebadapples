class CaCriminalIncident < ApplicationRecord
  def officers
    Officer
      .where('upper(first_name) = ?', first_name.upcase)
      .where('upper(last_name) = ?', last_name.upcase)
  end
end
