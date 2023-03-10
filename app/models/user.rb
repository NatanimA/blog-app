class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # Authorization rules for cancancan
  ROLES = %i[admin moderator author banned].freeze

  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy

  validates :name, presence: true, length: { minimum: 1, maximum: 20 }
  validates :posts_counter, presence: false, comparison: { greater_than_or_equal_to: 0 },
                            numericality: { only_integer: true }

  # This scope will find the amout of posts the user have and
  # it will try to reterive the informations by given author ID.
  scope :find_posts_amount, ->(id) { select(:posts_counter).where(id:) }

  # This method will take the authors Id as parameter, and updated count value
  # It will increment the posts_counter by the given count value the.
  def self.update_posts_counter(id, posts_counter)
    count = posts_counter
    User.where(id:).update(posts_counter: count)
  end

  # Here we can get posts that belongs to each user by just passing the ID of the author
  def recent_posts
    posts.order(created_at: 'DESC').first(3)
  end
end
