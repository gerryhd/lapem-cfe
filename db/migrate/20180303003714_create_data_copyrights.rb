class CreateDataCopyrights < ActiveRecord::Migration
  def change
    create_table :data_copyrights do |t|
      t.string :title
      t.string :author
      t.timestamps null: false
    end

    add_reference :copyrights, :data_copyright, index: true, foreign_key: true
  end
end
