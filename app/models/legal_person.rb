class LegalPerson < ActiveRecord::Base
  has_one :brand, as: :person

end
