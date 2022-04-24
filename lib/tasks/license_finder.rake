desc "Audit dependency licenses"
task :license_finder do
  sh 'bundle', 'exec', 'license_finder'
end
