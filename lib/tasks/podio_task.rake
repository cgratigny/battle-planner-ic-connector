namespace :podio_task do
  desc "Update all users from podio"
  task :sync => :environment do
    PodioSyncService.cache_all
  end
end
