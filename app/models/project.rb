class Project
  include Mongoid::Document
  field :name, type: String
  field :username, type: String
  field :completed, type: Mongoid::Boolean, default: false
  field :deadline, type: DateTime
  embeds_many :tasks
   # accepts_nested_attributes_for :tasks
end
