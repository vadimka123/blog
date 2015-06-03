class CommentsController < ApplicationController
  skip_before_filter  :verify_authenticity_token, :only => [:create]
  def create
    respond_to do |format|
      comment = Comment.create(text: params[:comment],
                               datetime: Date.today,
                               user_id: current_user.id)
      @post = Post.find(params[:post_id])
      array = @post.comment_id
      array.push(comment.id)
      @post.update_attributes(:comment_id => array)
      format.html {}
      format.js {}
      format.json {render json: @post, status: :created, location: @post}
    end
  end
end