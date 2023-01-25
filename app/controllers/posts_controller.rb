class PostsController < ApplicationController
  def index
    @post = Post.all().where(author:params[:user_id])
  end

  def show
    @post = Post.find_by(author:params[:user_id],id:params[:id])
  end
end
