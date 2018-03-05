class CreateReclaimedPriorities < ActiveRecord::Migration
  def change
    create_table :reclaimed_priorities do |t|
      t.string :number
      t.date :presentation_date
      t.references :country, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_reference :applications, :reclaimed_priority, index: true, foreign_key: true
  end
end
