class NaturalPerson < ActiveRecord::Base
  belongs_to :brand, as: :person

end
