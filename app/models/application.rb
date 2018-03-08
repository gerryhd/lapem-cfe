class Application < ActiveRecord::Base
  belongs_to :applicant
  belongs_to :application_type
  belongs_to :status_application
  has_one :data_general
  has_one :address_notification

  belongs_to :applicable, polymorphic: true


  validates_presence_of :application_type, :applicant
  accepts_nested_attributes_for :data_general
  accepts_nested_attributes_for :address_notification

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
