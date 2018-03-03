class CreateGeneralDataAuthors < ActiveRecord::Migration
  def change
    create_table :general_data_authors do |t|
      t.string :name
      t.string :first_last_name
      t.string :second_last_name
      t.string :nationality
      t.string :phone
      t.string :email
      t.string :curp
      t.string :rfc
      t.string :gender
      t.date :birth_date
      t.string :birth_location
      t.string :cell_phone
      t.integer :participation_percent
      t.text :participation_type

      t.timestamps null: false
    end

    add_reference :copyrights, :general_data_author, index: true, foreign_key: true
  end
end
