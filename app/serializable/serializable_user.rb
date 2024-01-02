class SerializableUser < JSONAPI::Serializable::Resource
  type 'users'
  attributes :id, :email, :name
end
