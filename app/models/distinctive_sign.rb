class DistinctiveSign < ActiveRecord::Base
  belongs_to :sign_type
  belongs_to :brand_type
  has_one :application, as: :applicable
  has_one :establishment_location

  accepts_nested_attributes_for :establishment_location

  mount_uploader :file_sign, DistinctiveFileUploader

  validates :sign_type, :brand_type, presence: true
end
