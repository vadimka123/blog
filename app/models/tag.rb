class Tag
  include Mongoid::Document
  field :tag, type: String
  field :col, type: Integer, default: 0
end