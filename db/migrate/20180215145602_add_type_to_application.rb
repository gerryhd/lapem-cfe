class AddTypeToApplication < ActiveRecord::Migration
  def change
    add_reference :applications, :application_type, index: true, foreign_key: true
  end
end
