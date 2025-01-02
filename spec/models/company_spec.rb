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

require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'associations' do
    it { should have_many(:addresses).dependent(:destroy) }
  end

  describe 'validations' do
    subject { FactoryBot.build(:company) }

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(256) }
    it { should validate_presence_of(:registration_number) }
    it { should validate_presence_of(:addresses) }
    it { should validate_uniqueness_of(:registration_number) }
  end
end
