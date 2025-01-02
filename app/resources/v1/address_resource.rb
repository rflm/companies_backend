class V1::AddressResource
  include Alba::Resource

  root_key :data

  attributes :id, :street, :city, :postal_code, :country, :created_at, :updated_at
end
