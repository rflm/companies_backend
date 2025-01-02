require 'rails_helper'

RSpec.describe "Api::V1::Companies", type: :request do
  describe "POST /create" do
    let(:company_params) do
      {
        name: "Acme Inc",
        registration_number: 123456,
        addresses_attributes: [
          {
            street: "123 Main St",
            city: "Springfield",
            postal_code: "12345",
            country: "USA"
          }
        ]
      }
    end

    it "creates a new company" do
      post api_v1_companies_path, params: { company: company_params }

      expect(response).to have_http_status(:created)

      expect(response.body).to include("Acme Inc")
      expect(response.body).to include("123456")
      expect(response.body).to include("123 Main St")
      expect(response.body).to include("Springfield")
      expect(response.body).to include("12345")
      expect(response.body).to include("USA")

      json = JSON.parse(response.body)
      data = json["data"]

      expect(data.keys.to_set).to eq(expected_company_keys)
      expect(data["addresses"].first.keys.to_set).to eq(expected_address_keys)
    end

    it "returns errors when invalid" do
      company = FactoryBot.create(:company, company_params)

      post api_v1_companies_path, params: { company: company_params }

      expect(response).to have_http_status(:unprocessable_entity)

      json = JSON.parse(response.body)

      expect(json.keys).to eq([ "errors" ])
      expect(json["errors"]["registration_number"]).to include("has already been taken")
    end
  end

  describe "POST /import_csv" do
    it "creates companies from CSV" do
      file = fixture_file_upload("v1/companies/valid.csv", "text/csv")
      post import_csv_api_v1_companies_path, params: { file: }

      expect(response).to have_http_status(:created)

      expect(response.body).to include("Example Co")
      expect(response.body).to include("123456789")
      expect(response.body).to include("Main St")
      expect(response.body).to include("New York")
      expect(response.body).to include("10001")
      expect(response.body).to include("USA")

      json = JSON.parse(response.body)

      expect(json["data"].size).to eq(2)
      expect(json["data"].first['addresses'].size).to eq(2)

      data = json["data"][0]

      expect(data.keys.to_set).to eq(expected_company_keys)
      expect(data["addresses"].first.keys.to_set).to eq(expected_address_keys)
    end

    it "returns errors when invalid" do
      file = fixture_file_upload("v1/companies/invalid.csv", "text/csv")

      expect {
        expect {
          post import_csv_api_v1_companies_path, params: { file: file }
        }.not_to change(Company, :count)
      }.not_to change(Address, :count)

      expect(response).to have_http_status(:unprocessable_entity)

      json = JSON.parse(response.body)

      expect(json.keys).to eq([ "errors" ])
      expect(json["errors"]["Another Co,123456789,789 Oak St,Chicago,60601,USA"]['registration_number'])
        .to include("has already been taken")
    end
  end

  private

  def expected_company_keys
    %w[id name registration_number addresses updated_at created_at].to_set
  end

  def expected_address_keys
    %w[id street city postal_code country updated_at created_at].to_set
  end
end
