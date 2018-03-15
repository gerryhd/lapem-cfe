class AddPhoneAndFaxToModels < ActiveRecord::Migration
  def change
    add_column :people, :fax, :string
    add_column :data_inventors, :phone, :string
    add_column :data_inventors, :fax, :string
    add_column :data_owners, :phone, :string
    add_column :data_owners, :fax, :string
    add_column :data_owners, :nationality, :string

  end
end
