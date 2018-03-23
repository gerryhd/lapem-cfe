class FixReclaimedPriority < ActiveRecord::Migration
  def change
    remove_reference :applications, :reclaimed_priority, index: true, foreign_key: true
    add_reference :reclaimed_priorities, :application, index: true, foreign_key: true
  end
end
