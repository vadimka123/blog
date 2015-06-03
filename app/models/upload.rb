class Upload < Post
  include Mongoid::Document
  include Mongoid::Paperclip
  has_mongoid_attached_file :file
  has_mongoid_attached_file :poster
  do_not_validate_attachment_file_type :file
  validates_attachment :poster, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] }
end