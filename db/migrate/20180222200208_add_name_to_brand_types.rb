class AddNameToBrandTypes < ActiveRecord::Migration
  def change
    add_column :brand_types, :name, :string
  end
end
