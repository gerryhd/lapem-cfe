class AddReferenceOnCopyright < ActiveRecord::Migration
  def change
    add_reference :general_data_authors, :copyright, index: true, foreign_key: true
  end
end
