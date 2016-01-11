class Task
  include Mongoid::Document

  field :deadline, type: DateTime
  field :completed, type: Mongoid::Boolean, default: false
  field :name, type: String
  embedded_in :project
  embeds_many :comments
  field :order, type: Integer
end