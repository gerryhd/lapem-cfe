class CreateObservations < ActiveRecord::Migration
  def change
    create_table :observations do |t|
      t.text :notes

      t.references :application, index: true, foreign_key: true
      t.references :administrator, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
