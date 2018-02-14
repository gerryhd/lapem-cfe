class CreateCopyrightBranches < ActiveRecord::Migration
  def change
    create_table :copyright_branches do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
