class CreateDataGenerals < ActiveRecord::Migration
  def change
    create_table :data_generals do |t|
      t.string :name
      t.string :nationality
      t.string :state
      t.references :application, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
