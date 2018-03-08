class ChangeReferenceInObservations < ActiveRecord::Migration
  def change
    remove_reference :observations, :administrator, index: true, foreign_key: true
    add_reference :observations, :user, index: true, foreign_key: true
  end
end
