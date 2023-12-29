namespace :firestore_task do
  desc "Refresh users from firestore"

  task :sync_all => :environment do
    Rake::Task["firestore_task:sync_users"].invoke
    Rake::Task["firestore_task:sync_plans"].invoke
    Honeybadger.check_in('pMI2mJ')
  end

  task :sync_users => :environment do
    FirestoreService.new.sync_users
  end

  task :sync_plans => :environment do
    FirestoreService.new.sync_plans
  end

  task :sync_all_progress => :environment do
    start_date = 14.days.ago.to_date
    end_date = Date.today.to_date
    (start_date..end_date).each do |date|
      FirestoreService.new(date: date).sync_progress
    end
  end

  task :sync_recent_progress => :environment do
    FirestoreService.new(date: 1.day.ago.to_date).sync_progress
    FirestoreService.new(date: Date.today).sync_progress
    Honeybadger.check_in('JEIxJM')
  end

end
