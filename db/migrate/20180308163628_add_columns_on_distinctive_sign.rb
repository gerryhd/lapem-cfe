class AddColumnsOnDistinctiveSign < ActiveRecord::Migration
  def change
    add_column :distinctive_signs, :distinctive_sign, :text, limit: 4294967295
    add_column :distinctive_signs, :used_previous,:boolean
    remove_column :distinctive_signs, :not_used
  end
end
