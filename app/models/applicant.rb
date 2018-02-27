class Applicant < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  belongs_to :user, dependent: :destroy

  has_many :applications, dependent: :destroy
  validates :email, presence: true, :uniqueness => {case_sensitive: false}, format: VALID_EMAIL_REGEX

  accepts_nested_attributes_for :user

  def full_name
    "#{self.name} #{self.last_name}"
  end

  def to_natural_person
    {
      date: DateTime.now.to_date,
      name: self.name,
      last_name: self.last_names[0],
      second_last_name: self.last_names[2],
      nationality: self.nationality,
      phone_number: self.phone,
      email: self.email
    }
  end

  def last_names
    self.last_name.split(" ")
  end
end
