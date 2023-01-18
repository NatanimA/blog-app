class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments

  # This scope will find the amount of comments for post
  # it will try to reterive the informations by given Post ID.
  scope :find_comments_amount, ->(id) { select(:comments_counter).where(id:) }

  # This scope will find the current amount of likes a post have by the given Post ID.
  scope :find_likes_amount, ->(id) { select(:likes_counter).where(id:) }

  # This method will update the amount of likes for a give post id.
  def self.update_likes_counter(id)
    count = Post.find_likes_amount(id).map(&:likes_counter)
    count = if count[0].nil?
              0 + 1
            else
              count[0] + 1
            end
    Post.where(id:).update(likes_counter: count)
  end

  # This method will take the Post Id as parameter and
  # It will increment the comments_counter by 1.
  def self.update_comments_counter(id)
    count = Post.find_comments_amount(id).map(&:comments_counter)
    count = if count[0].nil?
              0 + 1
            else
              count[0] + 1
            end
    Post.where(id:).update(comments_counter: count)
  end

  # Here we can reuse this code to find Posts that belongs to a user
  scope :posts_by_author_id, ->(author) { where(author:).order(created_at: 'DESC').first(3) }

  # Here It will call the method update_posts_counter that recides in the User Model.
  scope :update_posts_counter, ->(author) { User.update_posts_counter(author) }

  # Here we can call the method which recides in comments to find the 5 recent commnets for a post.
  scope :recent_posts_comment, ->(post) { Post.recent_posts_comment(post) }
end
