class AddressNotification < ActiveRecord::Base
  has_one :address_data, as: :addressable

  accepts_nested_attributes_for :address_data
end
