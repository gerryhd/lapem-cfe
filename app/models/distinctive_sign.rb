class DistinctiveSign < ActiveRecord::Base
  belongs_to :sign_type
  belongs_to :brand_type
  has_one :application, as: :applicable
  has_one :establishment_location, dependent: :destroy
  has_many :file_signs
  accepts_nested_attributes_for :establishment_location
  accepts_nested_attributes_for :file_signs

  # mount_uploader :file_signs, DistinctiveFileUploader
  validates :sign_type, :brand_type, presence: true
end
