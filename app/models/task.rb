class Task < ActiveRecord::Base
  has_many :comments
  belongs_to :project
  before_create :set_position

  validates :name, presence: true
  validates :project, presence: true
  validates :deadline, presence: true
  validates :done, :inclusion => {:in => [true, false]}





  def set_position
    a= self.project.tasks.order("position DESC").first ? self.project.tasks.order("position DESC").first.position : -1
    self.position=a+1
  end

end
