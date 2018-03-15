class IndustrialProperty < ActiveRecord::Base
  belongs_to :type_request
  belongs_to :design_type
  has_one :data_inventor, dependent: :destroy
  has_one :data_owner, dependent: :destroy

  accepts_nested_attributes_for :data_inventor
  accepts_nested_attributes_for :data_owner

end
