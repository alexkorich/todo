class Comment < ActiveRecord::Base
  belongs_to :task
  mount_uploader :attach, AttachUploader

  validates :text, presence: true
  # validates :author, presence: true
  validates :task, presence: true
end
