#need to adjust how often this runs? config/schedule.rb
#to run via term: rake delete_tasks

desc "Deletes tasks older than 7 days"
  task delete_tasks: :environment do
    Task.where(["created_at <= ?", 8.days.ago]).where(:completed_at => nil).destroy_all
    puts "Deleted tasks."
  end

