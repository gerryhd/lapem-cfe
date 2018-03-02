class AddApplicationToPatents < ActiveRecord::Migration
  def change
    add_reference :patents, :application, foreign_key: true
  end
end
