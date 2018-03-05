class RemoveFieldsOnAddressNotification < ActiveRecord::Migration
  def change
    remove_column :address_notifications, :zip_code
    remove_column :address_notifications, :street
    remove_column :address_notifications, :external_number
    remove_column :address_notifications, :internal_number
    remove_column :address_notifications, :colony
    remove_column :address_notifications, :municipality
    remove_column :address_notifications, :location
    remove_column :address_notifications, :federal_entity
    remove_column :address_notifications, :back_street
    remove_reference :address_notifications, :country, index: true, foreign_key: true
  end
end
