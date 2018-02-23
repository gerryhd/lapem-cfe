class BrandType < ActiveRecord::Base
  has_many :brand

  NOMINATIVE = 1
  INNOMINATED = 2
  THREE_DIMENSIONAL = 3

  # "Mixed  "
  DENOMINATION_AND_DESIGN = 4
  DENOMINATION_AND_3D = 5
  DESIGN_AND_3D = 6
  MIXED = 7

  def labeled_name
    if self.id > 3
      return "Mixed (#{self.name})"
    end

    name
  end
  
end