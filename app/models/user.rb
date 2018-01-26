class User < ActiveRecord::Base
  belongs_to :type_user
  
  # has_one :admin
  # has_one :applicant

  validates :username, presence: true, :uniqueness => {case_sensitive: false}
  validates :password, presence: true

  before_create :password_hash

  validates_confirmation_of :password, if: :save_password?
  validates_presence_of :password_confirmation, if: :password_changed?, on: :create

  attr_accessor :change_password
  
  def clearance_levels
    self.type_user.name
  end

  def password_hash
    var = if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(password, password_salt)
    end
    var
  end

  def save_password?
    self.change_password || self.new_record?
  end
end
