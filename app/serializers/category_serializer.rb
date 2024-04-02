class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :activities
  belongs_to :user
end
