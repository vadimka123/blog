class Gallery < Post
  include Mongoid::Document
  field :image_id, type: Array
  def image_list
  end
  def image_list=value
    self.image_id = Array.new
    value.each do |i|
      img = Image.create(image: i)
      self.image_id.push(img.id)
    end
  end
end