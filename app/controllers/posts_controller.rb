class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @post = Post.includes(:author, comments: [:author]).where(author: { id: params[:user_id] })
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @post }
    end
  end

  def new
    @user = current_user
    post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: } }
    end
  end

  def create
    @post = Post.new(params.require(:new_post).permit(:title, :text))
    user = current_user
    @post.author = user
    @post.comments_counter = 0
    @post.likes_counter = 0
    respond_to do |format|
      format.html do
        if @post.save
          flash[:success] = 'Post successfully created'
          redirect_to user_path(user.id)
        else
          flash[:error] = 'Something Went Wrong one or more field is empty'
          post = Post.new
          respond_to do |f|
            f.html { redirect_to request.referrer, locals: { post: } }
          end
        end
      end
    end
  end

  def show
    @post = Post.includes(:author, comments: [:author]).where(author: { id: params[:user_id] }, id: params[:id]).first
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path, status: :see_other
  end
end
