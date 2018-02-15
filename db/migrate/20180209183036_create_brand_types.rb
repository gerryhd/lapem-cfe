class CreateBrandTypes < ActiveRecord::Migration
  def change
    create_table :brand_types do |t|
      t.string :nominative
      t.string :innominated
      t.string :three_d
      t.string :denomination_design
      t.string :denomination_three_d
      t.string :design_three_d
      t.string :mixed

      t.references :brand, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
