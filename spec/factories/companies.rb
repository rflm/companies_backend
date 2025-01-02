# == Schema Information
#
# Table name: companies
#
#  id                  :integer          not null, primary key
#  name                :string           not null
#  registration_number :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_companies_on_name                 (name)
#  index_companies_on_registration_number  (registration_number) UNIQUE
#

FactoryBot.define do
  factory :company do
    name { "MyString" }
    registration_number { 1 }
  end
end
