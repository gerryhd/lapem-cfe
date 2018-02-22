class AddFilesToModels < ActiveRecord::Migration
  def change
    add_column :applications, :proof_files, :json
  end
end
