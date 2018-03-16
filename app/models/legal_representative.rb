class LegalRepresentative < ActiveRecord::Base
  belongs_to :copyright
  has_one :address_data, as: :addressable, foreign_key: 'owner_id', foreign_type: 'owner_type', dependent: :destroy
  accepts_nested_attributes_for :address_data
end
