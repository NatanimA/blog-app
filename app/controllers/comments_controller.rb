class CommentsController < ApplicationController
  def update_comments_counter(post)
    comments_counter = Post.find_comments_amount(post.id).map(&:comments_counter)
    comments_counter = comments_counter[0]
    comments_counter = if comments_counter.nil?
                         1
                       else
                         comments_counter + 1
                       end
    Post.update_comments_counter(post.id, comments_counter)
  end

  def create
    @comment = Comment.new(params.require(:new_comment).permit(:text))
    @comment.author = current_user
    @comment.post = Post.find(params[:post_id])

    # Increase Comments Counter
    update_comments_counter(Post.find(params[:post_id]))

    respond_to do |format|
      format.html do
        if @comment.save
          flash[:success] = 'comment successfully created'
          redirect_to user_post_path(@comment.author.id, params[:post_id])
        else
          flash[:error] = 'Something went wrong one or more field is empty'
          comment = Comment.new
          @user = current_user
          respond_to do |f|
            f.html { redirect_to request.referrer, locals: { comment: } }
          end
        end
      end
    end
  end

  def new
    comment = Comment.new
    @user = current_user
    respond_to do |f|
      f.html { render 'new', locals: { comment: } }
    end
  end
end
