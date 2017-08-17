class RemovePhotoUrl < ActiveRecord::Migration[5.1]
  def change
    remove_column :profiles, :photo_url
  end
end
