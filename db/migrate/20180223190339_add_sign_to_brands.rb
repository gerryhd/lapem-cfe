class AddSignToBrands < ActiveRecord::Migration
  def change
    add_reference :brands, :sign_type, index: true, foreign_key: true

  end
end
