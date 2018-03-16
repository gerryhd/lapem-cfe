class AddColumnsOnAddress < ActiveRecord::Migration
  def change
    add_column :address_data, :state, :string
  end
end
