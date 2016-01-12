class Comment
  include Mongoid::Document

  field :name, type: String
  field :text, type: String
  embedded_in :task
  field :author, type: String

end