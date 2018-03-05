class CreateDistinctiveSigns < ActiveRecord::Migration
  def change
    create_table :distinctive_signs do |t|
      t.text :description, limit: 4294967295
      t.date :first_date_use
      t.boolean :not_used
      t.integer :class_sign
      t.string :file_sign
      t.string :denomination
      t.text :tags, limit: 4294967295
      t.references :sign_type, index: true, foreign_key: true
      t.references :brand_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
