class Iframe < Post
  include Mongoid::Document
  field :href, type: String
end