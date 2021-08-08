namespace :podio_task do
  desc "Update all users from podio"
  task :sync => :environment do
    PodioSyncService.new.cache_all
  end
end
