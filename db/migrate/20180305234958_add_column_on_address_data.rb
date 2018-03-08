class AddColumnOnAddressData < ActiveRecord::Migration
  def change
    add_column :address_data, :between_streets, :string
  end
end
