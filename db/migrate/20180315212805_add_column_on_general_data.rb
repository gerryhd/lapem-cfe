class AddColumnOnGeneralData < ActiveRecord::Migration
  def change
    add_column :data_generals, :phone, :string
    add_column :data_generals, :fax, :string
  end
end
