# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every 1.day, at: ["0:00"], :roles => [:whenever] do
  rake "podio_task:sync"
end

every 1.day, at: ["1:00"], :roles => [:whenever] do
  rake "sync_users:sync_users"
end

every 1.day, at: ["1:15"], :roles => [:whenever] do
  rake "sync_users:sync_plans"
end

every 1.day, at: ["1:30"], :roles => [:whenever] do
  rake "sync_users:sync_all_progress"
end

every 1.hour, :roles => [:whenever] do
  rake "sync_users:sync_recent_progress"
end
