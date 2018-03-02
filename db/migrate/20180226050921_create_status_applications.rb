class CreateStatusApplications < ActiveRecord::Migration
  def change
    create_table :status_applications do |t|
      t.string :name
      t.timestamps null: false
    end

    remove_column :applications, :status
    add_reference :applications, :status_application, index: true, foreign_key: true
  end
end
