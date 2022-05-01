class MakeUuidThePrimaryKey < ActiveRecord::Migration[7.0]
  def up # rubocop:disable Metrics/AbcSize
    # Make UUID association columns not nullable
    change_column_null :external_documents, :incident_uuid, false
    change_column_null :friendly_id_slugs, :sluggable_uuid, false
    change_column_null :incident_roles, :officer_uuid, false
    change_column_null :incident_roles, :incident_uuid, false

    # Remove integer association columns
    remove_column :external_documents, :incident_id, :bigint
    remove_column :friendly_id_slugs, :sluggable_id, :bigint
    remove_column :incident_roles, :officer_id, :bigint # rubocop:disable Rails/BulkChangeTable
    remove_column :incident_roles, :incident_id, :bigint

    # Replace association columns with UUID association columns
    rename_column :external_documents, :incident_uuid, :incident_id
    rename_column :friendly_id_slugs, :sluggable_uuid, :sluggable_id
    rename_column :incident_roles, :officer_uuid, :officer_id
    rename_column :incident_roles, :incident_uuid, :incident_id

    # Add indexes for associations
    add_index :external_documents, :incident_id
    add_index :friendly_id_slugs, :sluggable_id
    add_index :incident_roles, :officer_id
    add_index :incident_roles, :incident_id

    # Remove integer primary key columns
    remove_column :external_documents, :id, :bigint, null: false
    remove_column :friendly_id_slugs, :id, :bigint, null: false
    remove_column :incident_roles, :id, :bigint, null: false
    remove_column :incidents, :id, :bigint, null: false
    remove_column :officers, :id, :bigint, null: false
    remove_column :users, :id, :bigint, null: false

    # Replace primary key columns with UUID columns
    rename_column :external_documents, :uuid, :id
    rename_column :friendly_id_slugs, :uuid, :id
    rename_column :incident_roles, :uuid, :id
    rename_column :incidents, :uuid, :id
    rename_column :officers, :uuid, :id
    rename_column :users, :uuid, :id

    # Promote UUID columns to primary keys
    execute 'ALTER TABLE external_documents ADD PRIMARY KEY (id);'
    execute 'ALTER TABLE friendly_id_slugs ADD PRIMARY KEY (id);'
    execute 'ALTER TABLE incident_roles ADD PRIMARY KEY (id);'
    execute 'ALTER TABLE incidents ADD PRIMARY KEY (id);'
    execute 'ALTER TABLE officers ADD PRIMARY KEY (id);'
    execute 'ALTER TABLE users ADD PRIMARY KEY (id);'

    # Add foreign keys
    add_foreign_key :incident_roles, :officers
    add_foreign_key :incident_roles, :incidents
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
