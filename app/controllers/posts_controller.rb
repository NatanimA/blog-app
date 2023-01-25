class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @post = @user.posts
  end

  def show
    @post = Post.find_by(author: params[:user_id], id: params[:id])
  end
end
