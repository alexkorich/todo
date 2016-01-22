class Comment < ActiveRecord::Base
   mount_uploader :attach, AttachUploader
end
