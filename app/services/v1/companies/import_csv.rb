require "csv"

class V1::Companies::ImportCsv
  attr_reader :file, :errors, :imported_companies

  def initialize(file)
    @file = file
    @errors = {}
    @imported_ids = []
  end

  def call
    ActiveRecord::Base.transaction do
      CSV.foreach(file.path, headers: true) do |row|
        import_row(row)
      end
    end

    @imported_companies = Company.where(id: @imported_ids).includes(:addresses)
  end

  private

  def import_row(row)
    company =
      Company.find_or_initialize_by(name: row["name"],
                                    registration_number: row["registration_number"])

    company.addresses.build(
      street: row["street"],
      city: row["city"],
      postal_code: row["postal_code"],
      country: row["country"]
    )

    if company.save
      @imported_ids << company.id
    else
      errors[row.to_s.strip] = company.errors

      raise ActiveRecord::Rollback
    end
  end
end
