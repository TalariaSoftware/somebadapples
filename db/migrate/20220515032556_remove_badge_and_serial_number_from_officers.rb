class RemoveBadgeAndSerialNumberFromOfficers < ActiveRecord::Migration[7.0]
  def change
    change_table :officers, bulk: true do |t|
      t.remove :serial_number, type: :string
      t.remove :badge_number, type: :string
    end
  end
end
