class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def show
    @post = User.recent_posts(params[:id])
  end

  def edit
    render 'edit'
  end
end
