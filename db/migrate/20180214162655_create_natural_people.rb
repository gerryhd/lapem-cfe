class CreateNaturalPeople < ActiveRecord::Migration
  def change
    create_table :natural_people do |t|
      t.date :date
      t.string :name
      t.string :last_name
      t.string :second_last_name
      t.string :nationality
      t.string :phone_number
      t.string :email

      t.references :brand, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
