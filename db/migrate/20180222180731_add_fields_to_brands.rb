class AddFieldsToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :text, :string
  end
end
