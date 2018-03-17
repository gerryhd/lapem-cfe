class Copyright < ActiveRecord::Base
  belongs_to :application
  belongs_to :copyright_branch
  has_one :legal_representative
  has_one :person_notification
  has_many :data_copyrights
  has_one :general_data_author

  accepts_nested_attributes_for :legal_representative
  accepts_nested_attributes_for :person_notification
  accepts_nested_attributes_for :data_copyrights
  accepts_nested_attributes_for :general_data_author

  validates_presence_of :title, :summary, :copyright_branch
end
