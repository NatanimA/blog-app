class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'
  validates :text, presence: true, length: { minimum: 3, maximum: 255 }

  # A method which returns the 5 most recent comments for a given post.
  scope :recent_posts_comment, ->(post) { where(post:).order(created_at: 'DESC').first(5) }

  # A method that updates the comments counter for a post.
  scope :update_comments_counter, ->(post, counter) { Post.update_comments_counter(post, counter) }
end
