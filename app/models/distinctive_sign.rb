class DistinctiveSign < ActiveRecord::Base
  belongs_to :sign_type
  has_one :application, as: :applicable

end
