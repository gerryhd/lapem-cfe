class AddNameToDataOwners < ActiveRecord::Migration
  def change
    add_column :data_owners, :name, :string
  end
end
