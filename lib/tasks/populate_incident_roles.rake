class DeprecatedIncident < ActiveRecord::Base # rubocop:disable Rails/ApplicationRecord
end

desc "Populate incident roles from deprecated incident table"
task populate_incident_roles: :environment do
  ActiveRecord::Base.transaction do
    DeprecatedIncident.all.each do |old_incident|
      new_incident = Incident.create!(
        heading: old_incident.heading,
        description: old_incident.description,
      )

      IncidentRole.create!(
        incident_id: new_incident.id,
        officer_id: old_incident.officer_id,
      )
    end
  end
end
