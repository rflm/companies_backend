class Api::V1::CompaniesController < ApplicationController
  def create
    company = Company.new(create_params)

    if company.save
      render json: V1::CompanyResource.new(company).serialize, status: :created
    else
      render json: { errors: company.errors }, status: :unprocessable_entity
    end
  end

  def import_csv
    importer = V1::Companies::ImportCsv.new(params[:file])

    importer.call

    if importer.errors.any?
      render json: { errors: importer.errors }, status: :unprocessable_entity
    else
      render json: V1::CompanyResource.new(importer.imported_companies).serialize, status: :created
    end
  end

  private

  def create_params
    params.require(:company)
      .permit(:name, :registration_number,
              addresses_attributes: %i[street city postal_code country])
  end
end
