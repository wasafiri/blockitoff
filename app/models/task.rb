class Task < ActiveRecord::Base
  belongs_to :list
  belongs_to :user

  default_scope { order('created_at DESC') }

  def expired?
    created_at >= 8.days.ago && completed_at.nil?
  end

  def mark_complete!
    self.completed_at = DateTime.now.utc
    save
  end

  def mark_incomplete!
    self.completed_at = nil
    save
  end

end
