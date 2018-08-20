class AddFieldsToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :company, :string
    add_column :applicants, :adscription_area, :string
    add_column :applicants, :charge, :string
    add_column :applicants, :rpe, :string
  end
end
