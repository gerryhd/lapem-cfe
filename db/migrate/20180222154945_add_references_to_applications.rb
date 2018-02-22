class AddReferencesToApplications < ActiveRecord::Migration
  def change
    add_reference :applications, :brand, index: true, foreign_key: true
    add_reference :applications, :patent, index: true, foreign_key: true
    add_reference :applications, :copyright, index: true, foreign_key: true

  end
end
