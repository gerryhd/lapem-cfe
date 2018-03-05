class AddressData < ActiveRecord::Base
  belongs_to :country
  belongs_to :addressable, polymorphic: true
end
