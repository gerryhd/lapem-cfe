class CreateCopyrights < ActiveRecord::Migration
  def change
    create_table :copyrights do |t|
      t.string :title
      t.text :summary

      # Add evidence file

      t.timestamps null: false
    end
  end
end
