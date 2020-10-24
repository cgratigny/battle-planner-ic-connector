namespace :podio_task do
  desc "Create absences for students"
  task :sync => :environment do
    ApplicationService.cache_all
  end
end
