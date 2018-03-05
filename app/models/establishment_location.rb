class EstablishmentLocation < ActiveRecord::Base
  belongs_to :distinctive_sign
  has_one :address_data, as: :addressable
end
