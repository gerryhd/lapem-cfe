class CreateDataInventors < ActiveRecord::Migration
  def change
    create_table :data_inventors do |t|
      t.string :nationality
      t.references :industrial_property, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
