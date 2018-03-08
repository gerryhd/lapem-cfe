class DataGeneral < ActiveRecord::Base
  belongs_to :application
  has_one :address_data, as: :addressable, foreign_key: 'owner_id', foreign_type: 'owner_type'
  has_one :person
  accepts_nested_attributes_for :person
end
