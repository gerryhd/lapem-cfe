class DataGeneral < ActiveRecord::Base
  belongs_to :application
  has_one :address_data, as: :addressable
  has_one :person
  accepts_nested_attributes_for :person
end
