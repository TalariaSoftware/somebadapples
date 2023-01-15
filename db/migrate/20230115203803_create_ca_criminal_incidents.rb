class CreateCaCriminalIncidents < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/AbcSize
    create_table :ca_criminal_incidents, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :crime_date
      t.string :charge1
      t.string :charge2
      t.string :charge3
      t.string :currently_employed
      t.string :department
      t.string :rank
      t.string :conviction1
      t.string :conviction2
      t.string :conviction3
      t.string :conviction4
      t.string :news_links

      t.belongs_to :incident

      t.timestamps
    end
  end
end
