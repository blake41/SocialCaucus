task :my_task => :environment do
  Activist.count
end

namespace :blake do
  desc 'force into amazon env'
  task :my_task2 do
    Rails.env = 'amazon'
    Rake::Task[:environment].invoke
    Rake::Task[:my_task].invoke
  end
end
