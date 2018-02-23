class AddPersonToBrand < ActiveRecord::Migration
  def change
    add_reference :brands, :person, index: true, polymorphic: true
  end
end
