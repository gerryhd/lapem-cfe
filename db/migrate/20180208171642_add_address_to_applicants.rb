class AddAddressToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :street, :string
    add_column :applicants, :ext_num, :string
    add_column :applicants, :int_num, :string
    add_column :applicants, :municipality, :string
    add_column :applicants, :zone_name, :string
    add_column :applicants, :zip_code, :integer
  end
end
