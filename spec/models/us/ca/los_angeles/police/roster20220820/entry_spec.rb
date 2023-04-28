require 'rails_helper'

RSpec.describe Us::Ca::LosAngeles::Police::Roster20220820::Entry do
  subject(:entry) { build :'us/ca/los_angeles/police/roster20220820_entry' }

  it { is_expected.to validate_presence_of(:employee_name) }
  it { is_expected.to validate_presence_of(:serial_no) }
  it { is_expected.to validate_presence_of(:rank_tile) }
  it { is_expected.to validate_presence_of(:area) }
  it { is_expected.to validate_presence_of(:sex) }
  it { is_expected.to validate_presence_of(:ethicity) }

  specify do
    expect(entry)
      .to validate_uniqueness_of(:serial_no).ignoring_case_sensitivity
  end
end
