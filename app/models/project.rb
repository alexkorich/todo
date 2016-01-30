class Project < ActiveRecord::Base
  has_many :tasks
  belongs_to :use

  validates :name, presence: true 
end
