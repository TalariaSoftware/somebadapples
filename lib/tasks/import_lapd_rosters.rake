desc "Import LAPD roster from 2022-08-20"
task import_lapd_roster20220820: :environment do
  Us::Ca::LosAngeles::Police::Roster20220820::Entry.destroy_all

  roster = Roo::Excelx.new(
    Rails.public_path.join(
      'us/ca/police/los_angeles/22-8154 Sworn Roster August 2022.xlsx',
    ),
  )

  attributes =
    roster
    .sheet(0)
    .parse(employee_name: 'EmployeeName', serial_no: 'SerialNo',
      rank_tile: 'RankTile', area: 'Area', sex: 'Sex',
      ethicity: 'Ethnicity')
    .reject { |row| row[:serial_no].blank? }

  Us::Ca::LosAngeles::Police::Roster20220820::Entry.create(attributes)
end
