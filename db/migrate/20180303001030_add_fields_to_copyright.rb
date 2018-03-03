class AddFieldsToCopyright < ActiveRecord::Migration
  def change
    add_column :copyrights, :titular_is_author, :boolean
    add_column :copyrights, :known_public, :boolean
    add_column :copyrights, :publication_date, :date
    add_column :copyrights, :is_derivated, :boolean
  end
end
