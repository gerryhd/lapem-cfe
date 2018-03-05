class DataGeneral < ActiveRecord::Base
  belongs_to :application
  has_one :address_data, as: :addressable
end
