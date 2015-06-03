class Post
  include Mongoid::Document
  field :category_id, type: Array
  field :comment_id, type: Array
  field :tag_id, type: Array
  field :title, type: String
  field :text, type: String
  field :date, type: Date
  def tag_list
    begin
      self.tag_id.map { |t| t.name }.join(', ')
    rescue
    end
  end
  def tag_list=value
    self.tag_id = Array.new
    value.split(',').each do |tags|
      count_tag = Tag.where(tag: tags).count
      tag_new = nil
      if count_tag == 0
        tag_new = Tag.create(tag: tags)
        tag_new.save
      else
        tag_1 = Tag.where(tag: tags)
        tag_1.each do |t|
          tag_new = t
        end
      end
      self.tag_id.push(tag_new.id)
    end
  end
  def self.search(search)
    if search
      any_of({:title => "/#{search}/"},{:text => "/#{search}/"})
    else
      find(:all)
    end
  end
end