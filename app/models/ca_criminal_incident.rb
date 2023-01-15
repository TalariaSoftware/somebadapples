class CaCriminalIncident < ApplicationRecord
  def agency
    Agency.find_by(
      name: CaCriminalIncident.agency_map[department],
    )
  end

  def officers
    Officer
      .where('upper(first_name) = ?', first_name.split.first.upcase)
      .where('upper(last_name) = ?', last_name.upcase)
  end

  def self.agency_map
    @agency_map ||= YAML.load_file(agency_map_file)
  end

  private_class_method def self.agency_map_file
    Rails.public_path.join('data/california-criminal-cops-agency-map.yml')
  end
end
