class Task < ActiveRecord::Base
  belongs_to :list

  def expired?
    created_at >= 8.days.ago && completed_at.nil?
  end

end
