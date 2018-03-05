class AddReferenceOnPerson < ActiveRecord::Migration
  def change
    add_reference :people, :data_general, index: true, foreign_key: true
  end
end
