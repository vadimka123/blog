class Stream < Post
  include Mongoid::Document
  include Mongoid::Paperclip
  field :name, type: String
end