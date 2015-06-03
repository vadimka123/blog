class CategoriesController < ApplicationController
  def show
    require 'rubygems'
    require 'nokogiri'
    page = Nokogiri::HTML(open('http://demo.themeinprogress.com/nova/'))
    @calendar = page.css('tbody').to_s
    @posts = Post.any_in(category_id: [params[:id]])
    @post_last = Post.order('date desc').limit(5)
    @tag_pop = Tag.order('col desc').limit(6)
    @categories = Category.all
  end
end