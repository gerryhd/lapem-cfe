class DataOwner < ActiveRecord::Base
  has_one :address_data, as: :addressable
end
