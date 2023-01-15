desc "Reindex search database"
task reindex_search: :environment do
  [Officer, Agency, Incident].map(&:reindex)
end
