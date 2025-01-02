class V1::CompanyResource
  include Alba::Resource

  root_key :data, :data

  attributes :id, :name, :registration_number, :created_at, :updated_at

  many :addresses, resource: V1::AddressResource
end
