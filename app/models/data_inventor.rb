class DataInventor < ActiveRecord::Base
  belongs_to :industrial_property
  has_one :address_data, as: :addressable
end
