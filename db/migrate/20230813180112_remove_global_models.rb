# rubocop:disable Metrics/AbcSize,Layout/LineLength
class RemoveGlobalModels < ActiveRecord::Migration[7.0]
  def change
    remove_index 'agencies_officers', ['agency_id'], name: 'index_agencies_officers_on_agency_id'
    remove_index 'agencies_officers', ['officer_id'], name: 'index_agencies_officers_on_officer_id'

    remove_foreign_key 'positions', 'agencies'
    remove_foreign_key 'positions', 'officers'
    remove_foreign_key 'roles', 'incidents'
    remove_foreign_key 'roles', 'officers'

    drop_view 'agencies_officers', materialized: true

    drop_table 'agencies', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.string 'name', default: '', null: false
      t.string 'short_name', default: '', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.string 'slug'
      t.index ['name'], name: 'index_agencies_on_name', unique: true, order: :desc
    end

    drop_table 'officers', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.string 'first_name'
      t.string 'last_name'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.string 'slug'
      t.string 'middle_name', default: '', null: false
      t.string 'suffix', default: '', null: false
      t.string 'post_id'
      t.index %w[last_name first_name middle_name], name: index_officers_on_last_name_and_first_name_and_middle_name, order: :desc
      t.index ['post_id'], name: 'index_officers_on_post_id', unique: true
      t.index ['slug'], name: 'index_officers_on_slug', unique: true
    end

    drop_table 'positions', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.uuid 'officer_id', null: false
      t.uuid 'agency_id', null: false
      t.string 'badge_number'
      t.string 'serial_number'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.date 'employment_start'
      t.date 'employment_end'
      t.string 'rank'
      t.index ['agency_id'], name: 'index_positions_on_agency_id'
      t.index ['officer_id'], name: 'index_positions_on_officer_id'
    end

    drop_table 'roles', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.string 'description', default: '', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.uuid 'officer_id', null: false
      t.uuid 'incident_id', null: false
      t.index ['incident_id'], name: 'index_roles_on_incident_id'
      t.index ['officer_id'], name: 'index_roles_on_officer_id'
    end
  end
end
# rubocop:enable Metrics/AbcSize,Layout/LineLength
