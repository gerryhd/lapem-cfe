class Brand < ActiveRecord::Base
  belongs_to :application
  
  has_one :brand_type
  has_one :person, polymorphic: true

  
end
