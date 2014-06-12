class Task < ActiveRecord::Base
  belongs_to :list
  belongs_to :user

  scope :active, -> { where(["created_at >= ?", 8.days.ago]) }

  def mark_complete!
    self.completed_at = DateTime.now.utc
    save
  end

  def mark_incomplete!
    self.completed_at = nil
    save
  end

end
