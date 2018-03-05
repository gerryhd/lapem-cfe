class IndustrialProperty < ActiveRecord::Base
  belongs_to :type_request
  belongs_to :design_type
end
