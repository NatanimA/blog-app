class LikesController < ApplicationController
  def new
    render "new"
  end

  def create
    @like = Like.new(params[:like])
    if @like.save
      flash[:success] = "Like successfully created"
      redirect_to @like
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

end
