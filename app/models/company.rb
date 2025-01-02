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

class Company < ApplicationRecord
  has_many :addresses, dependent: :destroy

  validates :name, :registration_number, :addresses, presence: true
  validates :registration_number, uniqueness: true

  accepts_nested_attributes_for :addresses
end
