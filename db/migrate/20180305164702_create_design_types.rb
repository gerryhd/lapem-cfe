class CreateDesignTypes < ActiveRecord::Migration
  def change
    create_table :design_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
