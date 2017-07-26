class RenameGoogleSubInUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :google_sub, :google_id
  end
end
