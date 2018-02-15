class CreateLegalPeople < ActiveRecord::Migration
  def change
    create_table :legal_people do |t|
      t.date :date
      t.string :denomination
      t.string :rfc
      t.string :nationality
      t.string :phone_number
      t.string :email

      t.references :brand, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
