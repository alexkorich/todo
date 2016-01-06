class Project
  include Mongoid::Document
  field :name, type: String
  field :completed, type: Mongoid::Boolean
end
