namespace :podio_task do
  desc "Update all users from podio"
  
  task :sync => :environment do
    PodioSyncService.new.cache_all
    Honeybadger.check_in('GQIdY7')
  end
end
