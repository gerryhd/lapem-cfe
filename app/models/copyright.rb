class Copyright < ActiveRecord::Base
  belongs_to :application
  belongs_to :copyright_branch
  has_one :legal_representative
  has_one :person_notification

  accepts_nested_attributes_for :legal_representative
  accepts_nested_attributes_for :person_notification

  validates_presence_of :title, :summary, :copyright_branch
end
