class Brand < ActiveRecord::Base
  has_one :brand_type
  has_one :legal_person
  has_one :moral_person

  
end
