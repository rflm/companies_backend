class Api::V1::CompaniesController < ApplicationController
  def create
    company = Company.new(create_params)

    if company.save
      render json: V1::CompanyResource.new(company).serialize, status: :created
    else
      render json: { errors: company.errors }, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:company)
      .permit(:name, :registration_number,
              addresses_attributes: %i[street city postal_code country])
  end
end
