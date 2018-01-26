class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :password_salt

      t.references :type_user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
