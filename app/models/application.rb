class Application < ActiveRecord::Base
  enum status: [:pending, :revision, :rejected, :approved]
  
  belongs_to :applicant
  belongs_to :application_type

  before_create :default_values
  
  validates_presence_of :application_type, :applicant

  def default_values
    self.status ||= :pending
  end
end
