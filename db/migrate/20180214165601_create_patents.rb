class CreatePatents < ActiveRecord::Migration
  def change
    create_table :patents do |t|
      t.string :title
      t.date :divulgation_date

      # Add file field

      t.timestamps null: false
    end
  end
end
