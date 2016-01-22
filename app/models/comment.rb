class Comment
  include Mongoid::Document
  include Rails.application.routes.url_helpers
  
  embedded_in :task

  field :text, type: String
  field :author, type: String
  field :attach 
  mount_uploader :attach, AttachUploader

end