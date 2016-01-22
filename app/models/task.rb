class Task
  include Mongoid::Document

  embedded_in :project
  embeds_many :comments
  
  field :deadline, type: DateTime
  field :completed, type: Mongoid::Boolean, default: false
  field :name, type: String
  field :order, type: Integer
  
end