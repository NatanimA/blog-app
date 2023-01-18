class User < ApplicationRecord
  has_many :comments
  has_many :posts, through: :comments
  has_many :posts
  has_many :likes
  has_many :posts, through: :likes

  #This scope will find the amout of posts the user have and
  #it will try to reterive the informations by given author ID.
  scope :find_posts_amount, ->(id) { select(:posts_counter).where(:id=> id)}


  #This method will take the authors Id as parameter and
  #It will increment the posts_counter by 1.
  def self.update_posts_counter(id)
       count = User.find_posts_amount(id).map(&:posts_counter)
       if count[0] == nil
        count = 0 + 1
       else
        count = count[0] + 1
       end
      User.where(:id => id).update(:posts_counter => count)
  end


  #Here we can get posts that belongs to each user by just passing the ID of the author
  scope :recent_posts, ->(id) { Post.posts_by_author_id(id)}
end
