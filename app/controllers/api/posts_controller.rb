class Api::PostsController < Api::ApiController
  def index
    @post = Post.includes(:author, comments: [:author]).where(author: { id: params[:user_id]})
    render :json => @post
  end
end
