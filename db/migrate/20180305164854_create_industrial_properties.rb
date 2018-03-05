class CreateIndustrialProperties < ActiveRecord::Migration
  def change
    create_table :industrial_properties do |t|
      t.boolean :is_applicant_invention
      t.string :title
      t.date :previous_release_date
      t.string :divisional_number
      t.string :divisional_legal_concept
      t.date :divisional_date
      t.references :design_type, index: true, foreign_key: true
      t.references :type_request, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
