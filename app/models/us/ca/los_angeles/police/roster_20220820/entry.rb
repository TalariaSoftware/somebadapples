class Us::Ca::LosAngeles::Police::Roster20220820::Entry < ApplicationRecord
  self.table_name_prefix = 'us_ca_los_angeles_police_roster20220820_'

  extend FriendlyId
  friendly_id :serial_no

  validates :employee_name, :serial_no, :rank_tile, :area,
    :sex, :ethicity, presence: true
  validates :serial_no, uniqueness: { case_sensitive: false }
end
