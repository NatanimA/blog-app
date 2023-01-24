class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      flash[:success] = 'comment successfully created'
      redirect_to @comment
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end

  def new
    render 'new'
  end
end
