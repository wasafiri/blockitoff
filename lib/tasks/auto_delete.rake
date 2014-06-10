#need to adjust how often this runs? config/schedule.rb

desc "Deletes tasks older than 7 days"
task delete_tasks: :environment do
  Task.where(created_at >= 8.days.ago && completed_at.nil?).destroy_all
end