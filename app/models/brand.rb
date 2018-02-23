class Brand < ActiveRecord::Base
  belongs_to :application
  
  belongs_to :brand_type
  belongs_to :sign_type
  belongs_to :person, polymorphic: true

  
end
