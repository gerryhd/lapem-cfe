class StatusApplication < ActiveRecord::Base
  PENDING = 1
  REJECTED = 2
  APPROVED = 3
  OBSERVATIONS = 4
  has_one :application
end
