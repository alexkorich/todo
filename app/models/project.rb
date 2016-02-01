class Project < ActiveRecord::Base
  has_many :tasks,-> {order "position ASC"}
  belongs_to :user

  validates :name, presence: true
  validates :deadline, presence: true
  validates :user, presence: true


end
