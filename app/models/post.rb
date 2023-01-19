class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments

  validates :title, presence: true, length: { minimum: 1, maximum: 255 }
  validates :comments_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }


  # Ths scope will find the amount of comments for post
  # it will try to reterive the informations by given Post ID.
  scope :find_comments_amount, ->(id) { select(:comments_counter).where(id:) }

  # This scope will find the current amount of likes a post have by the given Post ID.
  scope :find_likes_amount, ->(id) { select(:likes_counter).where(id:) }

  # This method will update the amount of likes for a give post id.
  def self.update_likes_counter(id, likes_counter)
    count = likes_counter
    Post.where(id:).update(likes_counter: count)
  end

  # This method will take the Post Id as parameter and updated count value
  # It will increment the comments_counter by the given count value.
  def self.update_comments_counter(id, comments_counter)
    count = comments_counter
    Post.where(id:).update(comments_counter: count)
  end

  # Here we can reuse this code to find Posts that belongs to a user
  scope :posts_by_author_id, ->(author) { where(author:).order(created_at: 'DESC').first(3) }

  # Here It will call the method update_posts_counter that recides in the User Model.
  scope :update_posts_counter, ->(author, counter) { User.update_posts_counter(author, counter) }

  # Here we can call the method which recides in comments to find the 5 recent commnets for a post.
  scope :recent_posts_comment, ->(post) { Comment.recent_posts_comment(post) }
end
