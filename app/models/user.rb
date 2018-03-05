class User < ActiveRecord::Base
  belongs_to :type_user
  
  has_one :administrator
  has_one :applicant

  validates :username, presence: true, :uniqueness => {case_sensitive: false}
  validates :password, presence: true, confirmation: true, if: :save_password?
  validates_presence_of :password_confirmation, if: :save_password?
  
  before_create :password_hash
  before_update :password_hash, if: :password_changed?

  attr_accessor :change_password

  accepts_nested_attributes_for :applicant
  
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

  def self.authenticate(username, password)
    user = find_by_username(username)
    if user && user.password == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    end
  end

  def applicant?
    self.type_user.id == TypeUser::APPLICANT
  end

  def admin?
    self.type_user.id == TypeUser::ADMIN
  end
end
