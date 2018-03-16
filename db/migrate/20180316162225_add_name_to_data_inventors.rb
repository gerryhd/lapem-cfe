class AddNameToDataInventors < ActiveRecord::Migration
  def change
    add_column :data_inventors, :name, :string
  end
end
