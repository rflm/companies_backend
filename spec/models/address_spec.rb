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

require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'associations' do
    it { should belong_to(:company) }
  end

  describe 'validations' do
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:country) }
  end
end
