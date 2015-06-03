class PostsController < ApplicationController
  skip_before_filter  :verify_authenticity_token, :only => [:create]
  def index
    require 'rubygems'
    require 'nokogiri'
    page = Nokogiri::HTML(open('http://demo.themeinprogress.com/nova/'))
    @calendar = page.css('tbody').to_s
    @posts = Post.all.order('date desc')
    @post_last = Post.order('date desc').limit(5)
    @tag_pop = Tag.order('col desc').limit(6)
    @categories = Category.all
  end

  def show
    @post = Post.find(params[:id])
    @post.tag_id.each do |t|
      tag = Tag.find(t)
      pop = tag.col
      tag.update_attribute(:col, pop + 1)
    end
    @comment = Comment.new
  end

  def new
    @post = Post.new
    @category = Category.all
  end

  def create
    require 'streamio-ffmpeg'
    respond_to do |format|
      categoryID = params[:post][:category_id]
      categoryID.shift
      if params[:post][:standart]
        post = Standart.create(category_id: categoryID,
                        tag_list: params[:post][:tag_list],
                        comment_id: [],
                        title: params[:post][:title],
                        text: params[:post][:text],
                        date: Date.today,
                        image: params[:post][:standart][:image])
      elsif params[:images]
        post = Gallery.create(category_id: categoryID,
                       tag_list: params[:post][:tag_list],
                       comment_id: [],
                       title: params[:post][:title],
                       text: params[:post][:text],
                       date: Date.today,
                       image_list: params[:images])
      elsif params[:post][:upload]
        file = params[:post][:upload][:file]
        type = file.content_type[0..4]
        path_tmp = Rails.root.join("public/tmp/#{file.original_filename}")
        File.open(path_tmp, 'wb') do |f|
          f.write file.read
        end
        if type == 'video'
          movie = FFMPEG::Movie.new(path_tmp)
          path = Rails.root.join("public/tmp/#{file.original_filename[0...-4]}.png")
          movie.transcode(path, '-ss 00:00:00.100 -an -f image2 -r 1/5')
          File.delete(path_tmp)
        elsif type == 'audio'
          response = `echoprint-codegen #{path_tmp} 10 30`
          artist = JSON.parse(response)[0]['metadata']['artist']
          title = JSON.parse(response)[0]['metadata']['title']
          File.delete(path_tmp)
          image_search = Google::Search::Image.new(:query => "#{artist} #{title}").first
          extension = File.extname(image_search.uri)
          path = Rails.root.join("public/tmp/#{file.original_filename[0...-4]}.#{extension}")
          image = MiniMagick::Image.open(image_search.uri)
          image.resize '580x388>'
          image.write(path)
        end
        poster = File.new(path)
        post = Upload.create(category_id: categoryID,
                      tag_list: params[:post][:tag_list],
                      comment_id: [],
                      title: params[:post][:title],
                      text: params[:post][:text],
                      date: Date.today,
                      file: params[:post][:upload][:file],
                      poster: poster)
        File.delete(path)
      elsif params[:post][:iframe]
        post = Iframe.create(category_id: categoryID,
                      tag_list: params[:post][:tag_list],
                      comment_id: [],
                      title: params[:post][:title],
                      text: params[:post][:text],
                      date:Date.today,
                      href: params[:post][:iframe][:href])
      elsif params[:post][:stream]
        post = Stream.create(category_id: categoryID,
                      tag_list: params[:post][:tag_list],
                      comment_id: [],
                      title: params[:post][:title],
                      text: params[:post][:text],
                      date: Date.today,
                      name: params[:post][:stream][:name])
      end
      format.html {redirect_to "/posts/#{post.id}/#{@name}"}
      format.js {}
      format.json {render json: post, status: :created}
    end
  end

  def search
    require 'rubygems'
    require 'nokogiri'
    page = Nokogiri::HTML(open('http://demo.themeinprogress.com/nova/'))
    @calendar = page.css('tbody').to_s
    @query = params[:query]
    @posts = Post.any_of({:title => /.*#{@query}.*/},{:text => /.*#{@query}.*/}).order('date asc')
    @post_last = Post.order('date desc').limit(5)
    @tag_pop = Tag.order('col desc').limit(6)
    @categories = Category.all
  end
end