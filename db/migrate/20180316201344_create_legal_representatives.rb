class CreateLegalRepresentatives < ActiveRecord::Migration
  def change
    create_table :legal_representatives do |t|
      t.string :name
      t.string :first_last_name
      t.string :second_last_name
      t.string :phone
      t.string :email
      t.string :curp
      t.string :rfc
      t.string :cell_phone
      t.string :name_representative
      t.references :copyright, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
