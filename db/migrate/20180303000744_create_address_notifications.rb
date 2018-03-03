class CreateAddressNotifications < ActiveRecord::Migration
  def change
    create_table :address_notifications do |t|
      t.string :zip_code
      t.string :street
      t.string :external_number
      t.string :internal_number
      t.string :colony
      t.string :municipality
      t.string :location
      t.string :federal_entity
      t.integer :back_street

      t.references :country, index: true, foreign_key: true
      t.references :application, index: true, foreign_key: true


      t.timestamps null: false
    end
  end
end
