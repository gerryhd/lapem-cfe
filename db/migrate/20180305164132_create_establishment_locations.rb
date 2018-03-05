class CreateEstablishmentLocations < ActiveRecord::Migration
  def change
    create_table :establishment_locations do |t|
      t.references :distinctive_sign, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
