class AddBranchToCopyright < ActiveRecord::Migration
  def change
    add_reference :copyrights, :copyright_branch, foreign_key: true
    add_reference :copyrights, :application, foreign_key: true
  end
end
