class RenameColumnInDisabledLists < ActiveRecord::Migration[5.1]
  def change
    rename_column :disabled_lists, :user_to_invite_id, :user_id
  end
end
