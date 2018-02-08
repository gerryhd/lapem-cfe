class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.integer :status

      t.references :applicant, index: true, foreign_key: true
      t.references :application_type, index: true, foreign_key: true
      
      t.timestamps null: false
    end
  end
end
