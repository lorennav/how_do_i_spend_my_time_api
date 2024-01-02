class SerializableActivity < JSONAPI::Serializable::Resource
  type 'activities'
  attributes :name, :description, :date, :start_time, :finish_time, :category
end
