class LegalPerson < ActiveRecord::Base
  belongs_to :brand, as: :person
  
end
