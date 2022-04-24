desc "Check for deviation from rails best practices"
task :rails_best_practices do
  sh 'bundle', 'exec', 'rails_best_practices'
end
