class CreateDataOwners < ActiveRecord::Migration
  def change
    create_table :data_owners do |t|
      t.string :rgp
      t.text :notification_people, limit: 4294967295
      t.references :industrial_property, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
