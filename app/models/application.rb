class Application < ActiveRecord::Base
  mount_uploaders :proof_files, ProofUploader
  serialize :proof_files, JSON
  
  belongs_to :applicant
  belongs_to :application_type

  has_one :brand
  has_one :patent
  has_one :copyright
  belongs_to :status_application

  
  validates_presence_of :application_type, :applicant

  scope :brands, ->{ where(application_type_id: ApplicationType::BRAND) }
  scope :patents, ->{ where(application_type_id: ApplicationType::PATENT) }
  scope :copyrights, ->{ where(application_type_id: ApplicationType::COPYRIGHT) }


  def self.statuses_t
    {
      "#{I18n.t('status.pending')}" => StatusApplication::PENDING,
      "#{I18n.t('status.revision')}" => StatusApplication::OBSERVATIONS,
      "#{I18n.t('status.rejected')}" => StatusApplication::REJECTED,
      "#{I18n.t('status.approved')}" => StatusApplication::APPROVED
    }
  end
end
