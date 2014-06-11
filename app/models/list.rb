class List < ActiveRecord::Base
  has_many :tasks
  belongs_to :user

  default_scope { order('created_at DESC') }

end
