class RenameProfileIdToUserId < ActiveRecord::Migration[5.1]
  def change
    rename_column :boards, :profile_id, :user_id
    rename_column :disabled_lists, :profile_id, :user_to_invite_id
    rename_column :messages, :profile_id, :user_id
  end
end
