class ApplicationType < ActiveRecord::Base
  has_many :applications

  BRAND = 1
  PATENT = 2
  COPYRIGHT = 3
end
