class CreateFileSigns < ActiveRecord::Migration
  def change
    create_table :file_signs do |t|
      t.references :distinctive_sign, index: true, foreign_key: true
      t.string :sign_file

      t.timestamps null: false
    end
    remove_column :distinctive_signs, :file_sign, :string
  end
end
