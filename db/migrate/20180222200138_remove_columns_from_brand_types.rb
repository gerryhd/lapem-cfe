class RemoveColumnsFromBrandTypes < ActiveRecord::Migration
  def change
    remove_column :brand_types, :nominative, :string
    remove_column :brand_types, :innominated, :string
    remove_column :brand_types, :three_d, :string
    remove_column :brand_types, :denomination_design, :string
    remove_column :brand_types, :denomination_three_d, :string
    remove_column :brand_types, :design_three_d, :string
    remove_column :brand_types, :mixed, :string
  end
end
