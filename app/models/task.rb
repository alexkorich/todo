class Task < ActiveRecord::Base
  has_many :comments
  belongs_to :task

end
