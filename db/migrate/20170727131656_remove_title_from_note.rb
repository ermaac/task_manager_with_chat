class RemoveTitleFromNote < ActiveRecord::Migration[5.1]
  def change
    remove_column :notes, :title
  end
end
