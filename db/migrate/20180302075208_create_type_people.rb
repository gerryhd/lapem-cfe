class CreateTypePeople < ActiveRecord::Migration
  def change
    create_table :type_people do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
