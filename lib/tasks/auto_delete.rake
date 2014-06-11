#need to adjust how often this runs? config/schedule.rb

desc "Deletes tasks older than 7 days"
task delete_tasks: :environment do
  if Task.where(created_at >= 8.days.ago && completed_at.nil?).destroy_all
    puts "Tasks deleted successfully"
  else
    puts "No tasks older than 8 days found."
  end
end