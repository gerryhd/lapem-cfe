class Application < ActiveRecord::Base
  belongs_to :applicant
  belongs_to :application_type
  belongs_to :status_application
  has_one :data_general, dependent: :destroy
  has_one :address_notification, dependent: :destroy

  belongs_to :applicable, polymorphic: true, dependent: :destroy

  scope :brands, -> {where(application_type_id: ApplicationType::BRAND)}
  scope :patents, -> {where(application_type_id: ApplicationType::PATENT)}
  scope :copyrights, -> {where(application_type_id: ApplicationType::COPYRIGHT)}


  validates_presence_of :application_type, :applicant
  accepts_nested_attributes_for :data_general
  accepts_nested_attributes_for :address_notification
  has_one :reclaimed_priority
  has_many :observations, dependent: :destroy
  accepts_nested_attributes_for :observations

  before_create :set_status

  def set_status
    self.status_application = StatusApplication.find(StatusApplication::PENDING)
  end
  #
  # def observations_attributes=(attributes)
  #   attributes.each do |attribute|
  #     if attribute[:id].present?
  #       self.observations.push(Observation.find attribute[:id])
  #     end
  #   end
  # end
end
