class CreateApplicationTypes < ActiveRecord::Migration
  def change
    create_table :application_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
