class Comment
  include Mongoid::Document
  field :text, type: String
  field :datetime, type: DateTime
  field :user_id, type: String
end