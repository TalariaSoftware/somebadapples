class RenameIncidentRoleToRole < ActiveRecord::Migration[7.0]
  def change
    rename_table :incident_roles, :roles
  end
end
