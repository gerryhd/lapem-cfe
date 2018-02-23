class Application < ActiveRecord::Base
  mount_uploaders :proof_files, ProofUploader
  serialize :proof_files, JSON

  
  enum status: [:pending, :revision, :rejected, :approved]
  
  belongs_to :applicant
  belongs_to :application_type

  has_one :brand
  has_one :patent
  has_one :copyright

  before_create :default_values
  
  validates_presence_of :application_type, :applicant

  scope :brands, ->{ where(application_type_id: ApplicationType::BRAND) }
  scope :patents, ->{ where(application_type_id: ApplicationType::PATENT) }
  scope :copyrights, ->{ where(application_type_id: ApplicationType::COPYRIGHT) }

  def default_values
    self.status ||= :pending
  end

  def self.statuses_t
    {
      "#{I18n.t('status.pending')}" => statuses[:pending],
      "#{I18n.t('status.revision')}" => statuses[:revision],
      "#{I18n.t('status.rejected')}" => statuses[:rejected],
      "#{I18n.t('status.approved')}" => statuses[:approved]
    }
  end
end
