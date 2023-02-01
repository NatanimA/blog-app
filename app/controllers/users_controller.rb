class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
    @btn = if current_user == @user
              true
           else
              false
           end
    @posts = Post.includes(:author).where(author: { id: params[:id] }).order(created_at: 'DESC').first(3)
  end

  def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
end
end
