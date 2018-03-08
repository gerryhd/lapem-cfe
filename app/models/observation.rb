class Observation < ActiveRecord::Base
  belongs_to :user
  belongs_to :application
  accepts_nested_attributes_for :application
end
