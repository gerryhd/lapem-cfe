class Application < ActiveRecord::Base
  belongs_to :applicant
  belongs_to :application_type
  belongs_to :status_application
  has_one :data_general, dependent: :destroy
  has_one :address_notification, dependent: :destroy

  belongs_to :applicable, polymorphic: true

  scope :brands, -> {where(application_type_id: ApplicationType::BRAND)}
  scope :patents, -> {where(application_type_id: ApplicationType::PATENT)}
  scope :copyrights, -> {where(application_type_id: ApplicationType::COPYRIGHT)}


  validates_presence_of :application_type, :applicant
  accepts_nested_attributes_for :data_general
  accepts_nested_attributes_for :address_notification
  has_one :reclaimed_priority
  has_many :observations, dependent: :destroy

  before_create :set_status

  def set_status
    self.status_application = StatusApplication.find(StatusApplication::PENDING)
  end


  def self.statuses_t
    {
        "#{I18n.t('status.pending')}" => StatusApplication::PENDING,
        "#{I18n.t('status.revision')}" => StatusApplication::OBSERVATIONS,
        "#{I18n.t('status.rejected')}" => StatusApplication::REJECTED,
        "#{I18n.t('status.approved')}" => StatusApplication::APPROVED
    }
  end
end
