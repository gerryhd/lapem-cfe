class CreatePersonNotifications < ActiveRecord::Migration
  def change
    create_table :person_notifications do |t|
      t.string :curp
      t.string :rfc
      t.string :name
      t.string :first_last_name
      t.string :second_last_name
      t.references :copyright, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
