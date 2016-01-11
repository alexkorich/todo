class Comment
  include Mongoid::Document

  field :name, type: String
  embedded_in :task
  field :author, type: String
  
end