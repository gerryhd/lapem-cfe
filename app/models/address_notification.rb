class AddressNotification < ActiveRecord::Base
  has_one :address_data, as: :addressable, foreign_key: 'owner_id', foreign_type: 'owner_type'
end
