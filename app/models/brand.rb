class Brand < ActiveRecord::Base
  belongs_to :application
  
  has_one :brand_type
  has_one :legal_person
  has_one :moral_person

  
end
