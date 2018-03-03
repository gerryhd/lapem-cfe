class CreateAddressAuthors < ActiveRecord::Migration
  def change
    create_table :address_authors do |t|
      t.string :zip_code
      t.string :street
      t.string :external_number
      t.string :internal_number
      t.string :colony
      t.string :municipality
      t.string :state

      t.references :country, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_reference :copyrights, :address_author, index: true, foreign_key: true
  end
end
