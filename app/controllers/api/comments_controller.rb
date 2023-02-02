class Api::CommentsController < Api::ApiController
  def index
    @comments = Comment.includes(:author,:post).where(author: {id: params[:user_id]}, post: { id: params[:post_id]})
    render :json => @comments
  end

  def create
    @comment = Comment.new(params.require(:comment).permit(:text,:post_id,:author_id))
    if @comment.save
      head :created
    else
      head :bad_request
    end
  end
end
