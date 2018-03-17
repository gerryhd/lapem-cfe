class AddReferenceOnDataCopyright < ActiveRecord::Migration
  def change
    add_reference :data_copyrights, :copyright, index: true, foreign_key: true
  end
end
