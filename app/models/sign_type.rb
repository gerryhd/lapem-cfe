class SignType < ActiveRecord::Base
  has_many :brand

  BRAND = 1
  COMMERCIAL_NOTICE = 2
  COLLECTIVE_BRAND = 3
  COMMERCIAL_NAME = 4
end
