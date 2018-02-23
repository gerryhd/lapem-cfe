class RemoveReferencesFromBrandTypes < ActiveRecord::Migration
  def change
    remove_reference :brand_types, :brand, index: true, foreign_key: true
  end
end
