class List < ActiveRecord::Base
  has_many :tasks

  validates :created_at, presence: true

end
