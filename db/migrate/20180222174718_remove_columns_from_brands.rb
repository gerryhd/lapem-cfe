class RemoveColumnsFromBrands < ActiveRecord::Migration
  def change
    remove_column :brands, :brand, :string
    remove_column :brands, :commercial_notice, :string
    remove_column :brands, :collective_brand, :string
    remove_column :brands, :commercial_name, :string
  end
end
