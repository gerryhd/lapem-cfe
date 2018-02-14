class AddBrandTypeToBrands < ActiveRecord::Migration
  def change
    add_reference :brands, :brand_type, foreign_key: true
  end
end
