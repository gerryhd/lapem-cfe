class CreateSignTypes < ActiveRecord::Migration
  def change
    create_table :sign_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
