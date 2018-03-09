class EstablishmentLocation < ActiveRecord::Base
  belongs_to :distinctive_sign
  has_one :address_data, as: :addressable, foreign_key: 'owner_id', foreign_type: 'owner_type'
  accepts_nested_attributes_for :address_data
end
