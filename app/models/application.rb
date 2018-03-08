class Application < ActiveRecord::Base
  mount_uploaders :proof_files, ProofUploader
  serialize :proof_files, JSON
  
  belongs_to :applicant
  belongs_to :application_type
  belongs_to :status_application

  belongs_to :applicable, polymorphic: true

  has_one :data_general
  has_one :address_notification
  has_one :reclaimed_priority
  has_many :observations
  validates_presence_of :application_type, :applicant

  def self.statuses_t
    {
      "#{I18n.t('status.pending')}" => StatusApplication::PENDING,
      "#{I18n.t('status.revision')}" => StatusApplication::OBSERVATIONS,
      "#{I18n.t('status.rejected')}" => StatusApplication::REJECTED,
      "#{I18n.t('status.approved')}" => StatusApplication::APPROVED
    }
  end
end
