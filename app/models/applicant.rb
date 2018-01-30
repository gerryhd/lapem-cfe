class Applicant < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  belongs_to :user
  validates :email, presence: true, :uniqueness => {case_sensitive: false}, format: VALID_EMAIL_REGEX

  accepts_nested_attributes_for :user
end
