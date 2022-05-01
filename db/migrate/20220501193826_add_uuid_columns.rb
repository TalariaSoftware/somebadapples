class AddUuidColumns < ActiveRecord::Migration[7.0]
  def change
    # Add UUID columns for ids
    # rubocop:disable Layout/LineLength
    add_column :external_documents, :uuid, :uuid, null: false, default: -> { 'gen_random_uuid()' }
    add_column :friendly_id_slugs, :uuid, :uuid, null: false, default: -> { 'gen_random_uuid()' }
    add_column :incident_roles, :uuid, :uuid, null: false, default: -> { 'gen_random_uuid()' }
    add_column :incidents, :uuid, :uuid, null: false, default: -> { 'gen_random_uuid()' }
    add_column :officers, :uuid, :uuid, null: false, default: -> { 'gen_random_uuid()' }
    add_column :users, :uuid, :uuid, null: false, default: -> { 'gen_random_uuid()' }
    # rubocop:enable Layout/LineLength

    # Add UUID columns for associations
    add_column :external_documents, :incident_uuid, :uuid
    add_column :friendly_id_slugs, :sluggable_uuid, :uuid
    add_column :incident_roles, :officer_uuid, :uuid # rubocop:disable Rails/BulkChangeTable
    add_column :incident_roles, :incident_uuid, :uuid
  end
end
