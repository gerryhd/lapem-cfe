class AddDetailsToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :name, :string
    add_column :applicants, :last_name, :string
    add_column :applicants, :phone, :string
    add_column :applicants, :position, :string
    add_column :applicants, :nationality, :string
  end
end
