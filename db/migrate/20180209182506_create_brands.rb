class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :brand
      t.string :commercial_notice
      t.string :collective_brand
      t.string :commercial_name

      t.timestamps null: false

      # Add reference to brand type later
    end
  end
end
