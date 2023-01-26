class LikesController < ApplicationController
  def update_likes_counter(post)
    likes_counter = Post.find_likes_amount(post.id).map(&:likes_counter)
    likes_counter = likes_counter[0]
    likes_counter = if likes_counter.nil?
                      1
                    else
                      likes_counter + 1
                    end
    Post.update_likes_counter(post.id, likes_counter)
  end

  def create
    @like = Like.new
    @like.author = current_user
    post = Post.find(params[:post_id])
    @like.post = post

    # Update the likes counter
    update_likes_counter(post)

    respond_to do |format|
      format.html do
        if @like.save
          flash[:success] = 'Like successfully created'
          redirect_to user_path(post.author.id)
        else
          flash[:error] = 'Something went wrong could not update likes'
          respond_to do |f|
            f.html { redirect_to request.referrer }
          end
        end
      end
    end
  end
end
