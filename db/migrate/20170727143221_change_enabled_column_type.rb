class ChangeEnabledColumnType < ActiveRecord::Migration[5.1]
  def change
    remove_column :chats, :enabled
    add_column :chats, :enabled, :boolean
  end
end
