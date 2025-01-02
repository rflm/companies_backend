require 'rails_helper'

RSpec.describe V1::Companies::ImportCsv do
  describe '#call' do
    let(:file) { fixture_file_upload('v1/companies/valid.csv', 'text/csv') }

    it 'imports companies from valid CSV' do
      importer = described_class.new(file)

      expect {
        expect {
          importer.call
        }.to change(Company, :count).by(2)
      }.to change(Address, :count).by(3)

      expect(importer.imported_companies.size).to eq(2)
      expect(importer.errors).to be_empty
    end

    it "doesn't import any company and returns errors when csv is invalid" do
      file = fixture_file_upload('v1/companies/invalid.csv', 'text/csv')
      importer = described_class.new(file)

      expect {
        expect {
          importer.call
        }.not_to change(Company, :count)
      }.not_to change(Address, :count)

      expect(importer.imported_companies).to be_empty
      expect(importer.errors).not_to be_empty

      expect(importer.errors.keys)
        .to include("Another Co,123456789,789 Oak St,Chicago,60601,USA")
    end
  end
end
