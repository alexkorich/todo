class Project
  include Mongoid::Document
  
  belongs_to :user
  validates_presence_of :user
  
  field :name, type: String
  field :username, type: String
  field :completed, type: Mongoid::Boolean, default: false
  field :deadline, type: DateTime
  embeds_many :tasks
  accepts_nested_attributes_for :tasks

end
