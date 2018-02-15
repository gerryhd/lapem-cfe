class Copyright < ActiveRecord::Base
  belongs_to :application
  
  belongs_to :copyright_branch

  validates_presence_of :title, :summary, :copyright_branch
end
