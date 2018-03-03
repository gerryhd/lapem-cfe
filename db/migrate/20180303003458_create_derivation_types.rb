class CreateDerivationTypes < ActiveRecord::Migration
  def change
    create_table :derivation_types do |t|
      t.string :name

      t.timestamps null: false
    end

    add_reference :copyrights, :derivation_type, index: true, foreign_key: true
  end
end
