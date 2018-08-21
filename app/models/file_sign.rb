class FileSign < ActiveRecord::Base
  mount_uploader :sign_file, DistinctiveFileUploader
  belongs_to :distinctive_sign
end
