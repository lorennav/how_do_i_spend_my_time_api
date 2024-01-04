class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name

  has_many :activities
  has_many :categories
end
