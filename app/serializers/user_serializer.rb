class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :bio, :photo, :email
  has_many :posts, foreign_key: :author
end
