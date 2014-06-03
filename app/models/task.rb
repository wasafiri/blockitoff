class Task < ActiveRecord::Base
  belongs_to :list

  validates :created_at, presence: true

  def expired?
    created_at >= 8.days.ago && completed_at.nil?
  end

end
