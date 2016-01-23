class Comment < ActiveRecord::Base
  belongs_to :task
  mount_uploader :attach, AttachUploader
end
