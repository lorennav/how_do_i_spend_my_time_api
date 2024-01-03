class SerializableCategory < JSONAPI::Serializable::Resource
  type 'categories'
  attributes :id, :name, :description
end
