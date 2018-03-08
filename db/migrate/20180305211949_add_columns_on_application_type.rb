class AddColumnsOnApplicationType < ActiveRecord::Migration
  def change
    add_column :application_types, :steps, :text, limit: 4294967295
  end
end
