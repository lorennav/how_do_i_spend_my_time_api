class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  has_many :activities
  belongs_to :user
end
