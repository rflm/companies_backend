# == Schema Information
#
# Table name: addresses
#
#  id          :integer          not null, primary key
#  company_id  :integer          not null
#  street      :string           not null
#  city        :string           not null
#  postal_code :string
#  country     :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_addresses_on_company_id  (company_id)
#

FactoryBot.define do
  factory :address do
    company { nil }
    street { "MyString" }
    city { "MyString" }
    postal_code { "MyString" }
    country { "MyString" }
  end
end
