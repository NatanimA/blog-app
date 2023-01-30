class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.includes(:author).where(author: { id: params[:id] }).order(created_at: 'DESC').first(3)
  end

  def edit
    render 'edit'
  end
end
