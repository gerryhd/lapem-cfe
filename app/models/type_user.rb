class TypeUser < ActiveRecord::Base
  has_many :users, dependent: :destroy
  ADMIN = 1
  APPLICANT = 2
end
