class DataGeneral < ActiveRecord::Base
  belongs_to :application
  has_one :address_data, as: :addressable, foreign_key: 'owner_id', foreign_type: 'owner_type', dependent: :destroy
  has_one :person, dependent: :destroy

  accepts_nested_attributes_for :person
  accepts_nested_attributes_for :address_data
end
