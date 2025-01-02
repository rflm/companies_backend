class CreateCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.integer :registration_number, null: false, index: { unique: true }

      t.timestamps
    end

    add_index :companies, :name
  end
end
