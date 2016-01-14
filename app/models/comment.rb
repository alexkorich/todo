class Comment
  include Mongoid::Document
  field :text, type: String
  embedded_in :task
  field :author, type: String

end