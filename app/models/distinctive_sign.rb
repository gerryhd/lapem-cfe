class DistinctiveSign < ActiveRecord::Base
  belongs_to :sign_type
  belongs_to :brand_type
  has_one :application, as: :applicable
  has_one :establishment_location

end
