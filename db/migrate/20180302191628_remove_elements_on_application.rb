class RemoveElementsOnApplication < ActiveRecord::Migration
  def change
    remove_reference :applications, :brand, index: true, foreign_key: true
    remove_reference :applications, :patent, index: true, foreign_key: true
    remove_reference :applications, :copyright, index: true, foreign_key: true
    remove_column :applications, :proof_files, index: true, foreign_key: true
    add_reference :applications, :applicable, polymorphic: true, index: true
  end
end
