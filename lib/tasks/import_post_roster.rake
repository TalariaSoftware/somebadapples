desc "Populate officers, positions, and agencies from POST roster"
task import_post_roster: :environment do
  file_path = Rails.root.join("public/data/california-post-roster-2022.csv")

  table = File.open(file_path) do |file|
    CSV.parse(file, headers: true)
  end

  # ActiveRecord::Base.transaction do
  #   table.each do |values|
  #     record = PostRecord.new(values)
  #     record.ensure_position
  #     print '.'
  #     STDOUT.flush
  #   end
  # end

  position_params = table.map do |values|
    record = PostRecord.new(values)
    print '.'
    STDOUT.flush
    record.position_params
  end

  puts "Creating records"
  STDOUT.flush
  Position.insert_all(position_params)
end
