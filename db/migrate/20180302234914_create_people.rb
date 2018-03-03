class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :first_last_name
      t.string :second_last_name
      t.string :nationality
      t.string :phone
      t.string :email
      t.string :curp
      t.string :social_reason
      t.string :rfc
      t.string :gender
      t.date :birth_date
      t.string :birth_location
      t.string :cell_phone
      t.integer :participation_percent
      t.text :participation_type

      t.references :type_person, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
