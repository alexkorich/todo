class Comment
  include Mongoid::Document
   include Rails.application.routes.url_helpers
  field :text, type: String
  embedded_in :task
  field :author, type: String

  field :attach 
  mount_uploader :attach, AttachUploader
end