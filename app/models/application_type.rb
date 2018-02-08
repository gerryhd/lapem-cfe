class ApplicationType < ActiveRecord::Base
  has_many :applications

  BRAND = 1
  PATENT = 2
  COPYRIGHT = 3

  def name_t
    I18n.t("application_type.#{self.name}")
  end
end
