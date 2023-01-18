class Like < ApplicationRecord
  belongs_to :author , class_name:"User"
  belongs_to :post

  scope :update_likes_counter, ->(post) { Post.update_likes_counter(post)}
end
